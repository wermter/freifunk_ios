class Region < Struct.new(:key, :name, :zoom, :location, :data_url, :twitter, :homepage)
  ALL = [
    Region.new(:hamburg,      "Hamburg",         7, [53.50, 10.00], "http://graph.hamburg.freifunk.net/nodes.json",                   "FreifunkHH",       "http://hamburg.freifunk.net/"),
    Region.new(:jena,         "Jena",            9, [50.90, 11.60], "http://freifunk-jena.de/ffmap/nodes.json",                       "freifunkjena",     "http://freifunk-jena.de/"),
    Region.new(:kiel,         "Kiel",            9, [54.30, 10.10], "http://freifunk.in-kiel.de/ffmap/nodes.json",                    "freifunkkiel",     "http://freifunk.in-kiel.de/"),
    Region.new(:luebeck,      "Lübeck",          8, [53.80, 10.70], "http://luebeck.freifunk.net/map/nodes.json",                     "freifunkluebeck",  "http://freifunk.metameute.de/"),
    Region.new(:lueneburg,    "Lüneburg",        9, [53.24, 10.42], "http://freifunk-lueneburg.de/karte/nodes.json",                  "FreifunkLG",       "http://freifunk-lueneburg.de"),
    Region.new(:paderborn,    "Paderborn",       9, [51.70,  8.75], "http://map.paderborn.freifunk.net/nodes.json",                   "FreifunkPB",       "http://paderborn.freifunk.net/"),
    Region.new(:wuppertal,    "Wuppertal",       9, [51.20,  7.15], "http://map.freifunk-wuppertal.net/nodes.json",                   "ffwtal",           "http://freifunk-wuppertal.net/"),
    Region.new(:dresden,      "Dresden",         9, [51.08, 13.73], "http://info.freifunk-dresden.de/info/ios-app-freifunk.json",     "ddmesh",           "http://www.ddmesh.de/"),
    Region.new(:leipzig,      "Leipzig",        10, [51.33, 12.33], "http://ffmap.leipzig.freifunk.net/nodes.json",                   "Freifunk_L",       "http://leipzig.freifunk.net/"),
    Region.new(:magdeburg,    "Magdeburg",      11, [52.14, 11.65], "http://map.md.freifunk.net/nodes.json",                          "freifunkmd",       "http://md.freifunk.net"),
    Region.new(:guetersloh,   "Gütersloh",       9, [51.91,  8.38], "http://guetersloh.freifunk.net/map/nodes.json",                  "FreifunkGT",       "http://guetersloh.freifunk.net/"),
    Region.new(:bielefeld,    "Bielefeld",       9, [52.04,  8.53], "http://map.freifunk-bielefeld.de/nodes.json",                    "FreifunkBI",       "http://freifunk-bielefeld.quakente.net/"),
    Region.new(:chemnitz,     "Chemnitz",       10, [50.82, 12.89], "http://curie.routers.chemnitz.freifunk.net/ffmap-d3/nodes.json", "FreifunkC",        "http://chemnitz.freifunk.net/"),
    Region.new(:ffrn,         "Rhein-Neckar",    9, [49.51,  8.56], "http://map.freifunk-rhein-neckar.de/nodes.json",                 "FFRheinNeckar",    "http://www.freifunk-rhein-neckar.de/"),
    Region.new(:ruhr,         "Ruhrgebiet",      8, [51.47,  7.11], "http://map.freifunk-ruhrgebiet.de/nodes.json",                   "ffruhr",           "http://freifunk-ruhrgebiet.de/"),
    Region.new(:moehne,       "Soest+HSK",       8, [51.49,  8.13], "http://moehne-vis.freifunk-rheinland.net/nodes.json",            "FFMoehne",         "http://freifunk-moehne.de/"),
    Region.new(:muenster,     "Münster",         8, [51.95,  7.62], "http://freifunk-muenster.de/map/nodes.json",                     "Freifunk_MS",      "http://freifunk-muenster.de/"),
    Region.new(:braunschweig, "Braunschweig",   10, [52.27, 10.53], "http://freifunk-bs.de/nodes_compat.json",                        "freifunk_bs",      "http://freifunk-bs.de/"),
    Region.new(:mzwi,         "Mainz/Wiesbaden",10, [50.03,  8.24], "http://map.freifunk-mainz.de/nodes.json",                        ["freifunkmainz", "freifunkwi"], ["http://www.freifunk-mainz.de", "http://freifunk-wiesbaden.de/"]),
    Region.new(:fulda,        "Fulda",           9, [50.55,  9.68], "http://map.freifunk-fulda.de/nodes.json",                        "FreifunkFulda"     "http://freifunk-fulda.de/")    
  ]

  def self.all
    ALL.sort { |a, b| a.key <=> b.key }
  end

  def self.find(key)
    all.detect { |region| region.key == key }
  end
end
