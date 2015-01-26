class NodeRepository
  def initialize(nodes)
    @nodes = nodes
  end

  def reset
    @nodes = nil
  end

  def sorted
    @sorted ||= all.sort_by { |node| node.name.downcase }
  end

  def online
    @online ||= all.select(&:online?)
  end

  def offline
    @offline ||= all.select(&:offline?)
  end

  def geo
    @geo ||= all.select(&:geo?)
  end

  def find(query)
    sorted.select do |node|
      tokenize(query).any? do |token|
        normalize(node.name) =~ /#{token}/
      end
    end
  end

  def all
    @nodes
  end

  private

  def tokenize(string)
    string.split.map { |token| normalize(token) }.reject(&:empty?)
  end

  def normalize(string)
    string.gsub(/[^\w]/, '').downcase
  end
end
