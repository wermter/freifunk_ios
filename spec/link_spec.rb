describe Link do
  it "validates the link" do
    data = ["link_id", "quality", "source", "target", "type"]
    Link.new(*data).valid?.should.eql true
  end

  it "has valid links" do
    json = BW::JSON.parse(LINKS)
    link = Link.from_json(json).first

    link.link_id.should.eql "66:70:02:5e:a9:1a-de:ad:be:ef:22:22"
    link.quality.should.eql "1.143, 1.062"
    link.source.should.eql  147
    link.target.should.eql  402
    link.type.should.eql    "vpn"
    link.macs.should.eql    ["66:70:02:5e:a9:1a", "de:ad:be:ef:22:22"]
  end
end

LINKS = <<-LINKS
{
    "links": [
        {
            "id": "66:70:02:5e:a9:1a-de:ad:be:ef:22:22",
            "quality": "1.143, 1.062",
            "source": 147,
            "target": 402,
            "type": "vpn"
        }
    ]
}
LINKS
