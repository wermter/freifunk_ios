class Region
  attr_reader :key, :name, :url

  def initialize(key, name, url)
    @key  = key
    @name = name
    @url  = url
  end

  def self.from_json(json)
    Array(json[:communities]).map do |key, it|
      name  = it[:name]
      url   = it[:url]

      new(key, name, url)
    end
  end
end
