class MapController < UIViewController

  FILTER_ITEMS = ["Alle", "Online", "Offline", "Mesh"]

  attr_reader :map

  def init
    (super || self).tap do |it|
      it.tabBarItem = UITabBarItem.alloc.initWithTitle("Karte", image: UIImage.imageNamed('location.png'), tag: 0)
    end
  end

  def viewDidLoad
    view.backgroundColor = UIColor.lightGrayColor
    @map = MKMapView.alloc.initWithFrame(view.bounds)
    @map.mapType = MKMapTypeStandard
    @map.delegate = self
    @map.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    view.addSubview(@map)

    @track_button = MKUserTrackingBarButtonItem.alloc.initWithMapView(map)
    self.navigationItem.rightBarButtonItems = [@track_button]

    image = UIImage.imageNamed("loopback.png")
    @loading_button = UIBarButtonItem.alloc.tap do |button|
      button.initWithImage(image, style: UIBarButtonItemStylePlain, target: self, action: 'toggle_loading:')
      button.tintColor = Color::GRAY
    end
    self.navigationItem.leftBarButtonItems = [@loading_button]

    @control = UISegmentedControl.alloc.tap do |control|
      control.initWithItems(FILTER_ITEMS)
      control.selectedSegmentIndex = 1
      control.addTarget(self, action: 'filter_map:', forControlEvents: UIControlEventValueChanged)
    end
    self.navigationItem.titleView = @control

    reload
  end

  def viewDidUnload
    @map = nil
  end


  def viewDidDisappear(animated)
    disable_loading
  end

  def mapView(mapView, viewForAnnotation: annotation)
    return if annotation.is_a? MKUserLocation

    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(:node_annotation)
      view.annotation   = annotation
      view
    else
      view = MKPinAnnotationView.alloc.tap do |it|
        it.initWithAnnotation(annotation, reuseIdentifier: :node_annotation)
        it.canShowCallout  = true
        button = UIButton.buttonWithType(UIButtonTypeInfoLight)
        button.addTarget(self, action: 'show_details:', forControlEvents: UIControlEventTouchUpInside)
        it.rightCalloutAccessoryView = button
      end
    end
    view.animatesDrop = false
    view.pinColor     = annotation.online? ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed
    view
  end

  def mapView(mapView, rendererForOverlay: overlay)
    return unless overlay.is_a? MKPolyline

    MKPolylineRenderer.alloc.tap do |renderer|
      renderer.initWithPolyline(overlay)
      renderer.strokeColor = Color::LIGHT
      renderer.lineWidth   = 4
    end
  end

  def center(node)
    location = CLLocationCoordinate2DMake(*node.geo)
    region = MKCoordinateRegionMakeWithDistance(location, 500, 500)
    map.setRegion(region, animated:true)
    map.selectAnnotation(node, animated: true)
  end

  def reset_selection(index = 0)
    @control.selectedSegmentIndex = index
    filter_map
  end

  def reload
    init_map
    filter_map
  end

  protected

  def timer
    @timer ||= EM.add_periodic_timer 5.0 do
      trigger_reload
    end
  end

  def trigger_reload
    delegate.file_loader.download do |state|
      if state
        delegate.reload
        filter_map
      else
        App.alert("Fehler beim laden...")
      end
    end
  end

  def toggle_loading(sender)
    if @live_loading
      disable_loading
    else
      @live_loading = true
      @loading_button.tintColor = Color::LIGHT
      trigger_reload
      timer
    end
  end

  def disable_loading
    @live_loading = false
    @loading_button.tintColor = Color::GRAY
    EM.cancel_timer(timer) if timer
    @timer = nil
  end

  def show_details(sender)
    controller = DetailsController.new
    controller.node = map.selectedAnnotations[0]
    navigationController.pushViewController(controller, animated: true)
  end

  def filter_map(sender = nil)
    map.removeAnnotations(map.annotations.reject { |a| a.is_a? MKUserLocation })
    map.removeOverlays(map.overlays)
    case @control.selectedSegmentIndex
    when 0
      map.addAnnotations(delegate.node_repo.all.select(&:geo?))
    when 1
      map.addAnnotations(delegate.node_repo.online.select(&:geo?))
    when 2
      map.addAnnotations(delegate.node_repo.offline.select(&:geo?))
    when 3
      connections = delegate.link_repo.connections(delegate.node_repo.all.select(&:geo?))
      map.addAnnotations(connections.flatten.uniq)
      connections.each do |source, target|
        coords = Pointer.new(CLLocationCoordinate2D.type, 2)
        coords[0] = source.coordinate
        coords[1] = target.coordinate
        line = MKPolyline.polylineWithCoordinates(coords, count: 2)
        map.addOverlay(line)
      end
    end
  end

  def init_map
    location = CLLocationCoordinate2DMake(*delegate.region.location)
    region = MKCoordinateRegionMakeWithDistance(location, delegate.region.zoom * 5000, delegate.region.zoom * 5000)
    map.setRegion(region, animated:true)
  end

  def delegate
    UIApplication.sharedApplication.delegate
  end
end
