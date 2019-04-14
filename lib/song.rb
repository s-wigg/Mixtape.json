class Song

  attr_accessor :id, :artist, :title

  def initialize(json)
    @id = json["id"]
    @artist = json["artist"]
    @title = json["title"]
  end

end
