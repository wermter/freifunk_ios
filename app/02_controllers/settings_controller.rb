class SettingsController < UITableViewController
  def init
    (super || self).tap do |it|
      it.tabBarItem = UITabBarItem.alloc.initWithTitle("Einstellungen", image:UIImage.imageNamed('settings.png'), tag:2)
    end
  end

  def reload
    tableView.reloadData
  end

  def loadView
    self.tableView = UITableView.alloc.tap do |tableView|
      tableView.initWithFrame(tableView.frame, style: UITableViewStyleGrouped)
      tableView.dataSource = tableView.delegate = self
    end
  end

  def viewWillAppear(animated)
    navigationItem.title = "With 💛 from St.Pauli"
  end

  def numberOfSectionsInTableView(tableView)
    4
  end

  def tableView(tableView, numberOfRowsInSection: section)
    case section
    when 0
      1
    when 1
      2
    when 2
      delegate.region_repo.all.size
    when 3
      2
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    tableView.dequeueReusableCellWithIdentifier(:link_cell) || UITableViewCell.alloc.tap do |cell|
      cell.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: :link_cell)
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    end
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.detailTextLabel.text = ""
    case indexPath.section
    when 0
      cell.textLabel.text       = "Knoten aktualisieren"
      cell.detailTextLabel.text = "zuletzt aktualisiert #{delegate.file_loader.last_update}"
    when 1
      case indexPath.row
      when 0
        cell.textLabel.text = delegate.region.name
        cell.accessoryType  = UITableViewCellAccessoryCheckmark
        cell.selectionStyle = UITableViewCellSelectionStyleBlue
      when 1
        cell.textLabel.text = delegate.region.url
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyleGray
      end
    when 2
      region = delegate.region_repo.all[indexPath.row]
      cell.textLabel.text = region.name
      if delegate.region == region
        cell.accessoryType  = UITableViewCellAccessoryCheckmark
        cell.selectionStyle = UITableViewCellSelectionStyleBlue
      else
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyleGray
      end
    when 3
      case indexPath.row
      when 0
        cell.textLabel.text = "Coding: @phoet"
      when 1
        cell.textLabel.text = "Version: #{App.version}"
      end
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    case indexPath.section
    when 0
      current_cell = tableView.cellForRowAtIndexPath(indexPath)
      arrow = current_cell.accessoryView
      current_cell.accessoryView = spinner
      spinner.startAnimating

      delegate.file_loader.download do |state|
        current_cell.accessoryView = arrow
        spinner.stopAnimating
        if state
          reload_controllers
        else
          App.alert("Fehler beim laden...")
        end
      end
    when 1
      case indexPath.row
      when 1
        open_url(delegate.region.url)
      end
    when 2
      App::Persistence['region'] = delegate.region_repo.all[indexPath.row].key
      reload_controllers
    when 3
      case indexPath.row
      when 0
        open_url("http://twitter.com/phoet")
      when 1
        open_url("https://www.github.com/phoet/freifunk_ios/")
      end
    end
  end

  protected

  def reload_controllers
    delegate.reload
    tabBarController.viewControllers.each do |navigation_controller|
      navigation_controller.viewControllers.each do |controller|
        controller.reload if controller.respond_to? :reload
      end
    end
  end

  def spinner
    @spinner ||= UIActivityIndicatorView.alloc.tap do |spinner|
      spinner.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
      spinner.frame = CGRectMake(0, 0, 24, 24)
    end
  end

  def open_url(url)
    url = NSURL.URLWithString(url)
    UIApplication.sharedApplication.openURL(url)
  end

  def delegate
    UIApplication.sharedApplication.delegate
  end
end
