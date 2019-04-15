require 'json'
require_relative 'mixtape'
require_relative 'change'

class Cli_mixtape_editor

  attr_accessor :mix, :changes

  def run
    mixtape_json = convert_to_json(ARGV[0])
    changes_file = convert_to_json(ARGV[1])
    output_file_destination = ARGV[2]

    @mix = Mixtape.new(mixtape_json)
    @changes = Change.new(changes_file, @mix)

    update_mixtape
  end

  def convert_to_json(file)
    raise "Error: File #{file} is empty" if File.empty?(file)
    parsed_json = JSON.parse(File.read(file))
    rescue JSON::ParserError => e
      raise "#{file} is invalid JSON and cannot be parsed #{e}"
    return parsed_json
  end

  def update_mixtape

    @changes.add_playlist_for_user.each do |add_playlist|
      @mix.playlists << Playlist.new(add_playlist)
    end

    @changes.add_song_to_playlist.each do |add_song|
      playlist_to_update = @mix.find_playlist_by_id(add_song[:playlist_id])
      playlist_to_update.song_ids << add_song[:song_id]
    end

    @changes.remove_playlists.each do |playlist_to_remove|
      @mix.playlists.delete_if { |pl| pl.id == playlist_to_remove[:playlist_id]}
    end
  end

  def write_updated_mixtape

  end
end
