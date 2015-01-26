describe Node do
  it "creates valid nodes" do
    json = BW::JSON.parse(NODES)
    node = Node.from_json(json).first

    node.node_id.should.eql   "1"
    node.name.should.eql      "Sparkassenplatz8-hinten"
    node.title.should.eql     "Sparkassenplatz8-hinten"
    node.subtitle.should.eql  "1"
    node.community.should.eql "emskirchen"
    node.lat.should.eql       49.549516955195
    node.long.should.eql      10.717663777727
    node.clients.should.eql   0
    node.online?.should.eql   true
    node.offline?.should.eql  false
    node.valid?.should.eql    true
    node.coordinate.should.be.instance_of? CLLocationCoordinate2D
  end
end

NODES = <<-NODES
{
    "allTheRouters": [
        {
            "clients": 0,
            "community": "emskirchen",
            "id": "1",
            "lat": "49.549516955195",
            "long": "10.717663777727",
            "name": "Sparkassenplatz8-hinten",
            "status": "online"
        }
    ]
}
NODES
