class Region < Struct.new(:key, :name, :zoom, :location, :data_url, :twitter, :homepage)
  ALL = [
    Region.new(:hamburg,    "Hamburg",         7, [53.50, 10.00], "http://graph.hamburg.freifunk.net/nodes.json",               "FreifunkHH",       "http://hamburg.freifunk.net/"),
    Region.new(:jena,       "Jena",            9, [50.90, 11.60], "http://map.freifunk-jena.de/ffmap/nodes.json",               "freifunkjena",     "http://freifunk-jena.de/"),
    Region.new(:kiel,       "Kiel",            9, [54.30, 10.10], "http://freifunk.in-kiel.de/ffmap/nodes.json",                "freifunkkiel",     "http://freifunk.in-kiel.de/"),
    Region.new(:luebeck,    "Lübeck",          8, [53.80, 10.70], "http://luebeck.freifunk.net/map/nodes.json",                "freifunkluebeck",  "http://freifunk.metameute.de/"),
    Region.new(:lueneburg,  "Lüneburg",        9, [53.24, 10.42], "http://freifunk-lueneburg.de/karte/nodes.json",              "freifunk",         "http://freifunk-lueneburg.de"),
    Region.new(:paderborn,  "Paderborn",       9, [51.70,  8.75], "http://map.paderborn.freifunk.net/nodes.json",               "FreifunkPB",       "http://paderborn.freifunk.net/"),
    Region.new(:wuppertal,  "Wuppertal",       9, [51.20,  7.15], "http://map.freifunk-wuppertal.net/nodes.json",               "ffwtal",           "http://freifunk-wuppertal.net/"),
    Region.new(:dresden,    "Dresden",         9, [51.08, 13.73], "http://info.freifunk-dresden.de/info/ios-app-freifunk.json", "ddmesh",           "http://www.ddmesh.de/"),
    Region.new(:leipzig,    "Leipzig",        10, [51.33, 12.33], "http://ffmap.leipzig.freifunk.net/nodes.json",               "Freifunk_L",       "http://leipzig.freifunk.net/"),
    Region.new(:magdeburg,  "Magdeburg",      11, [52.14, 11.65], "http://map.md.freifunk.net/nodes.json",                      "freifunkmd",       "http://md.freifunk.net"),
    Region.new(:mzwi,       "Mainz/Wiesbaden",10, [50.03,  8.24], "http://map.freifunk-mainz.de/nodes.json",                    ["freifunkmainz", "freifunkwi"], ["http://www.freifunk-mainz.de", "http://freifunk-wiesbaden.de/"]),
  ]

  def self.all
    ALL.sort { |a, b| a.key <=> b.key }
  end

  def self.find(key)
    all.detect { |region| region.key == key }
  end
end
