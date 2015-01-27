class AppDelegate
  attr_reader :file_loader, :node_repo, :region_repo

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    reload

    UISearchBar.appearance.tintColor = Color::LIGHT
    UITabBar.appearance.tintColor    = Color::LIGHT
    UINavigationBar.appearance.setTitleTextAttributes(NSForegroundColorAttributeName => Color::LIGHT)

    @window = UIWindow.alloc.tap do |window|
      window.initWithFrame(UIScreen.mainScreen.bounds)
      window.rootViewController = tabbar_controller
      window.tintColor        = Color::LIGHT
      window.backgroundColor  = Color::GRAY
      window.makeKeyAndVisible
    end
    true
  end

  def region
    if key = App::Persistence['region']
      region_repo.find(key)
    end || region_repo.all.first
  end

  def reload
    @file_loader  = FileLoader.new
    @region_repo  = RegionRepository.new(@file_loader.load_regions)
    @node_repo    = NodeRepository.new(@file_loader.load_nodes(region))
  end

  def coordinate
    current = node_repo.geo
    if current.empty?
      [53.0, 7.0]
    else
      lat = long = 0
      current.each { |node| lat += node.lat; long += node.long }
      [lat / current.size, long / current.size]
    end
  end

  private

  def tabbar_controller
    @tabbar_controller ||= UITabBarController.alloc.tap do |controller|
      controller.init
      controller.viewControllers = [map_controller, list_controller, settings_controller]
      controller.selectedIndex   = 0
    end
  end

  def list_controller
    @list_controller ||= UINavigationController.alloc.tap do |controller|
      root_controller = ListController.new
      controller.initWithRootViewController(root_controller)
    end
  end

  def map_controller
    @map_controller ||= UINavigationController.alloc.tap do |controller|
      root_controller = MapController.new
      controller.initWithRootViewController(root_controller)
    end
  end

  def settings_controller
    @settings_controller ||= UINavigationController.alloc.tap do |controller|
      root_controller = SettingsController.new
      controller.initWithRootViewController(root_controller)
    end
  end
end
