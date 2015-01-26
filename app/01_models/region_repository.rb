class RegionRepository
  def initialize(regions)
    @regions = regions
  end

  def reset
    @regions = nil
  end

  def sorted
    all.sort_by { |region| region.name.downcase }
  end

  def find(key)
    all.find { |region| region.key == key }
  end

  def all
    @regions
  end
end
