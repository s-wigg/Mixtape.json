require_relative 'mixtape'
require_relative 'cli_mixtape_editor'

class Change

  attr_accessor :add_song_to_playlist, :add_playlist_for_user, :remove_playlists

  def initialize(input, mix)
    @mix = mix

    @add_song_to_playlist = songs_to_add(input["add_song_to_playlist"])

    @add_playlist_for_user = playlists_to_add(input["add_playlist_for_user"])

    @remove_playlists = playlists_to_remove(input["remove_playlist"])
  end

  def songs_to_add(playlist_changes)
    sanitized_changes = []
    playlist_changes.each do |change|
      raise "Invalid Song to add to Playlist" unless valid_song_inputs?(change)

      if change["title"]
        song = @mix.find_song_by_title(change["title"])

        sanitized_changes << {
          playlist_id: change["playlist_id"],
          song_id: song.id
        }
      else
        sanitized_changes << {
          playlist_id: change["playlist_id"],
          song_id: change["song_id"]
        }
      end
    end
    return sanitized_changes
  end

  def valid_song_inputs?(song_change)
    if song_change["playlist_id"] && song_change["song_id"]
      return true
    elsif song_change["playlist_id"] && song_change["title"] && song_change["artist"]
        return true
    else
      return false
    end
  end

  def playlists_to_add(new_playlists)
    sanitized_playlists = []
    i = 1
    current_num_of_playlist = @mix.playlists.length
    new_playlists.each do |playlist|
      raise "Invalid Playlist to Add" unless valid_playlist_input?(playlist)

      user_id = @mix.find_user_by_name(playlist["user_name"]).user_id

      if playlist["song_ids"]
        sanitized_playlists << {
          user_id: user_id.to_s,
          song_ids:  playlist["song_ids"],
          id: (current_num_of_playlist + i).to_s
        }
      elsif playlist["songs"]
        song_ids = collect_song_ids(playlist["songs"])
        sanitized_playlists << {
          user_id: user_id.to_s,
          song_ids:  song_ids,
          id: (current_num_of_playlist + i).to_s
        }
      end
      i += 1
    end
    return sanitized_playlists
  end

  def collect_song_ids(list_of_songs)
    song_ids = []

    list_of_songs.each do |find_song|
      song_to_add = @mix.find_song_by_title(find_song["title"])
      song_ids << song_to_add.id
    end
    return song_ids
  end

  def valid_playlist_input?(playlist)
    if playlist["user_name"] && playlist["song_ids"]
      return true
    elsif playlist["user_name"] && playlist["songs"]
      return true
    else
      return false
    end
  end

  def playlists_to_remove(to_remove)
    removal_list = []

    to_remove.each do |removal|
      if removal["playlist_id"]
        removal_list << {
          playlist_id: removal["playlist_id"]
        }
      elsif removal["user_id"]
        user = @mix.find_user_by_id(removal["user_id"])
        playlist = @mix.find_playlist_by_user_id(user.user_id)

        if playlist
          removal_list << {
            playlist_id: playlist.id
          }
        else
          # if there's no playlist for that user, just move on for now
          # maybe that user's playlist already got deleted
          # otherwise more comprehensive thought about error handling generally
          # and likely use cases/edge cases is required
          next
        end
      end
    end
    return removal_list
  end
end
