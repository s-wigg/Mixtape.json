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

  def find_playlist_by_id(playlist_id)
    @playlists.select { |playlist| playlist.id == playlist_id}.first
  end

  def find_playlist_by_user_id(user_id)
    @playlists.select { |playlist| playlist.user_id == user_id }.first
  end

  def find_user_by_id(user_id)
    @users.select { |user| user.user_id == user_id }.first
  end

  def find_user_by_name(user_name)
    @users.select { |user| user.user_name == user_name }.first
  end

  def find_song_by_title(song_title)
    #TODO no guarantee with more data that song_title is unique
    # Add search by artist at a minimum
    @songs.select { |song| song.title == song_title }.first
  end

end
