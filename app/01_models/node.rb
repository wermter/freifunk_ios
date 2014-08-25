class Node
  include CoreLocation::DataTypes

  attr_reader :node_id, :name, :geo, :flags, :macs

  def initialize(node_id, name, geo, flags, macs)
    @node_id    = node_id
    @name       = name
    @geo        = geo
    @flags      = flags
    @macs       = macs.split(", ")
  end

  def title
    name
  end

  def subtitle
    node_id
  end

  def coordinate
    LocationCoordinate.new(geo.first, geo.last).api
  end

  def geo?
    !geo.nil?
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
