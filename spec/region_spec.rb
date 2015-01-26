describe Region do
  it "creates valid regions" do
    json = BW::JSON.parse(REGIONS)
    region = Region.from_json(json).first

    region.key.should.eql   "Freifunk Bielefeld"
    region.name.should.eql  "Freifunk Bielefeld"
    region.url.should.eql   "http://www.freifunk-badoeynhausen.de"
  end
end

REGIONS = <<-REGIONS
{
    "communities": {
        "Freifunk Bielefeld": {
            "name": "Freifunk Bielefeld",
            "url": "http://www.freifunk-badoeynhausen.de"
        }
    }
}
REGIONS
