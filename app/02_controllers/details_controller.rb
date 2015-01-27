class DetailsController < UITableViewController
  attr_accessor :node

  def loadView
    self.tableView = UITableView.alloc.tap do |tableView|
      tableView.initWithFrame(tableView.frame, style: UITableViewStyleGrouped)
      tableView.dataSource = tableView.delegate = self
    end
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(false, animated: true)
    navigationItem.title = node.name
  end

  def numberOfSectionsInTableView(tableView)
    3
  end

  def tableView(tableView, titleForHeaderInSection: section)
    {
      0 => "Info",
      1 => "Status",
    }[section]
  end

  def tableView(tableView, numberOfRowsInSection: section)
    case section
    when 0
      2
    when 1
      2
    when 2
      1
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    (tableView.dequeueReusableCellWithIdentifier(:detail_cell) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: :detail_cell)).tap do |cell|
      if indexPath.section == 2
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyleGray
      else
        cell.accessoryType  = UITableViewCellAccessoryNone
        cell.selectionStyle = UITableViewCellSelectionStyleNone
      end
    end
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    case indexPath.section
    when 0
      case indexPath.row
      when 0
        cell.textLabel.text = "#{node.name} (#{node.node_id})"
      when 1
        cell.textLabel.text = node.community
      end
    when 1
      case indexPath.row
      when 0
        cell.textLabel.text = "Status: #{node.status}"
      when 1
        cell.textLabel.text = "Clients: #{node.clients}"
      end
    when 2
      cell.textLabel.text = "Location: #{node.lat.round(2)} / #{node.long.round(2)}"
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    if indexPath.section == 2
      if navigationController.tabBarController.selectedIndex == 1
        navigationController.tabBarController.viewControllers.first.popToRootViewControllerAnimated false
        navigationController.tabBarController.viewControllers.first.viewControllers.first.center node
        navigationController.tabBarController.selectedIndex = 0
      end

      navigationController.popViewControllerAnimated true
    end
  end
end