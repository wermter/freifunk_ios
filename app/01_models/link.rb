class Link
  attr_reader :link_id, :quality, :source, :target, :type, :macs

  def initialize(link_id, quality, source, target, type)
    @link_id = link_id
    @quality = quality
    @source  = source
    @target  = target
    @type    = type
  end

  def macs
    link_id.split("-")
  end

  def valid?
    !link_id.nil?
  end

  def in_valid?
    !valid?
  end

  def self.from_json(json)
      Array(json[:links]).map do |it|
        link_id = it[:id]
        quality = it[:quality]
        source  = it[:source]
        target  = it[:target]
        type    = it[:type]

        new(link_id, quality, source, target, type)
      end
  end
end
