describe FileLoader do
  it "reads nodes from file" do
    nodes = loader.load_nodes
    nodes.size.should.satisfy { |result| result > 100 }
    nodes.first.should.be.is_a? Node
  end

  it "reads links from file" do
    links = loader.load_links
    links.size.should.satisfy { |result| result > 100 }
    links.first.should.be.is_a? Link
  end

  # it "downloads a new file" do
  #   @state = nil
  #   loader.download do |state|
  #     @state = state
  #     resume
  #   end
  #   wait_max(2.0) { @state.should == true }
  # end

  def loader
    FileLoader.new(Region::ALL.first)
  end
end
