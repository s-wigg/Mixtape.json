class Playlist

  attr_accessor :user_id, :id, :song_ids

  def initialize(json)
    @user_id = json["user_id"]
    @id = json["id"]
    @song_ids = json["song_ids"]
  end

end
