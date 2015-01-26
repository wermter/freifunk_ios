class Node
  attr_reader :node_id, :name, :geo, :flags, :macs

  def initialize(node_id, name, geo, flags, macs)
    @node_id    = node_id
    @name       = name
    @geo        = geo
    @flags      = flags
    @macs       = macs.nil? ? [] : macs.split(", ")
  end

  def title
    name
  end

  def subtitle
    node_id
  end

  def coordinate
    CLLocationCoordinate2DMake(*geo)
  end

  def geo?
    geo.is_a?(Array) && geo.size == 2
  end

  def online?
    flags["online"]
  end

  def offline?
    !online?
  end

  def gateway?
    flags["gateway"]
  end

  def client?
    flags["client"]
  end

  def valid?
    if geo?
      return false if geo.first.abs > 90
      return false if geo.last.abs > 90
    end
    !node_id.nil? && !name.nil? && name.length > 0
  end

  def self.from_json(json)
    Array(json[:nodes]).map { |it|
      node_id = it[:id]
      name    = it[:name]
      geo     = it[:geo]
      flags   = it[:flags]
      macs    = it[:macs]

      new(node_id, name, geo, flags, macs)
    }.select(&:valid?)
  end
end
