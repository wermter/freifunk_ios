class FileLoader
  URL = "http://www.freifunk-karte.de/data.php"

  def download(&block)
    AFMotion::HTTP.get(URL) do |response|
      if state = response.success?
        response.body.writeToFile(download_path, atomically: true)
      end
      block.call(state)
    end
  end

  def last_update
    File.mtime(file_path).strftime('%d.%m.%Y %H:%M')
  end

  def check_state(&block)
    AFMotion::HTTP.head(URL) do |response|
      if state = !!response.headers
        remote  = NSDate.dateWithNaturalLanguageString(response.headers["Last-Modified"])
        local   = File.mtime(file_path)
        state   = remote > local
      end
      block.call(state)
    end
  end

  def download_path
    "#{App.documents_path}/nodes.json"
  end

  def local_path
    "#{App.resources_path}/data/nodes.json"
  end

  def file_path
    File.exists?(download_path) ? download_path : local_path
  end

  def load_nodes(region)
    load_json { |json| Node.from_json(json).select { |node| node.community == region.key } }
  end

  def load_regions
    load_json { |json| Region.from_json(json) }
  end

  def load_json
    content = File.open(file_path) { |file| file.read }
    yield BW::JSON.parse(content)
  rescue BubbleWrap::JSON::ParserError => e
    puts e
    []
  end
end
