class Song

  attr_accessor :id, :artist, :title

  def initialize(json)
    @id = json["id"]
    @artist = json["artist"]
    @title = json["title"]
  end

  def song_to_json
    json_song = {}
    json_song["artist"] = @artist
    json_song["id"] = @id
    json_song["title"] = @title
    return json_song
  end
end
