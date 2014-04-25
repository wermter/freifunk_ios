describe Node do
  it "validates the node" do
    data = ["node_id", "name", "geo", "flags", "macs"]
    Node.new(*data).valid?.should.eql true
  end

  it "creates valid nodes" do
    json = BW::JSON.parse(NODES)
    node = Node.from_json(json).first

    node.node_id.should.eql         "66:70:02:b5:d9:26"
    node.name.should.eql            "brachvogel05"
    node.title.should.eql           "brachvogel05"
    node.subtitle.should.eql        "66:70:02:b5:d9:26"
    node.geo.map(&:to_i).should.eql [53, 9]
    node.flags.should.eql           "client" => false, "gateway" => false, "legacy" => true, "online" => true
    node.macs.should.include("64:70:02:b5:d9:26")
    node.online?.should.eql         true
    node.client?.should.eql         false
    node.gateway?.should.eql        false
    node.coordinate.should.be.instance_of? CLLocationCoordinate2D
  end
end

NODES = <<-NODES
{
    "nodes": [
        {
            "flags": {
                "client": false,
                "gateway": false,
                "legacy": true,
                "online": true
            },
            "geo": [
                53.600378,
                9.872321
            ],
            "id": "66:70:02:b5:d9:26",
            "macs": "64:70:02:b5:d9:26, 66:70:02:b5:d9:26, 66:70:02:b5:d9:27",
            "name": "brachvogel05"
        }
    ]
}
NODES
