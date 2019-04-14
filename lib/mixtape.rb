require_relative 'user'
require_relative 'playlist'
require_relative 'song'
class Mixtape

  attr_accessor :users, :playlists, :songs

  def initialize(input)
    @users = create(input["users"], "User")
    @playlists = create(input["playlists"], "Playlist")
    @songs = create(input["songs"], "Song")
  end

  def create(input, type)
    list = []
    klass = Object.const_get(type)
    input.each do |obj|
      list << klass.new(obj)
    end
    return list
  end

end
