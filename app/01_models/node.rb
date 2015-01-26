class Node
  attr_reader :node_id, :name, :clients, :community, :lat, :long, :status

  def initialize(node_id, name, clients, community, lat, long, status)
    @node_id    = node_id
    @name       = name
    @clients    = clients
    @community  = community
    @lat        = lat
    @long       = long
    @status     = status
  end

  def title
    name
  end

  def subtitle
    node_id
  end

  def coordinate
    CLLocationCoordinate2DMake(lat, long)
  end

  def geo?
    lat && long
  end

  def online?
    status == "online"
  end

  def offline?
    !online?
  end

  def valid?
    return false if lat > 90 || long > 90

    !node_id.nil? && !name.nil? && name.length > 0
  end

  def self.from_json(json)
    Array(json[:allTheRouters]).map do |it|
      node_id   = it[:id]
      name      = it[:name]
      clients   = it[:clients]
      community = it[:community]
      lat       = it[:lat].to_f
      long      = it[:long].to_f
      status    = it[:status]

      new(node_id, name, clients, community, lat, long, status)
    end.select(&:valid?)
  end
end
