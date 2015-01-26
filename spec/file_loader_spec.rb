describe FileLoader do
  it "reads nodes from file" do
    nodes = loader.load_nodes
    nodes.size.should.satisfy { |result| result > 100 }
    nodes.first.should.be.is_a? Node
  end

  it "reads regions from file" do
    regions = loader.load_regions
    regions.size.should.satisfy { |result| result > 10 }
    regions.first.should.be.is_a? Region
  end

  def loader
    FileLoader.new
  end
end
