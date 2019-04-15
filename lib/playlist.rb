class Playlist

  attr_accessor :user_id, :id, :song_ids

  def initialize(json)
    @user_id = json["user_id"] || json[:user_id]
    @id = json["id"] || json[:id]
    @song_ids = json["song_ids"] || json[:song_ids]
  end

  def playlist_to_json
    json_playlist = {}
    json_playlist["user_id"] = @user_id
    json_playlist["id"] = @id
    json_playlist["song_ids"] = @song_ids
    return json_playlist
  end

end
