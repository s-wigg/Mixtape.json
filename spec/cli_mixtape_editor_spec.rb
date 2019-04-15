require "cli_mixtape_editor"
require "change"
require 'mixtape'
require 'pry'

describe Cli_mixtape_editor do
    before do
      @editor = Cli_mixtape_editor.new

      mixtape_json = @editor.convert_to_json("data/mixtape.json")

      @editor.mix = Mixtape.new(mixtape_json)
      changes_file = @editor.convert_to_json("data/changes.json")
      @editor.changes = Change.new(changes_file, @editor.mix)

      @editor.update_mixtape
    end

    it "adds song to a playlist by song id" do
      @editor.mix.find_playlist_by_id("1").song_ids.include? "1"
    end

    it "adds song to a playlist by song title" do
      @editor.mix.find_playlist_by_id("1").song_ids.include? "6"
    end

    it "adds playlist for user with song ids" do
      @editor.mix.find_playlist_by_user_id("4").song_ids.equal? ["1", "6"]
    end

    it "adds playlist for user with song titles" do
      @editor.mix.find_playlist_by_user_id("6").song_ids.equal? ["17", "18"]
    end

    it "removes playlist by playlist id" do
      @editor.mix.find_playlist_by_id("2").nil?
    end

    it "removes playlist by user id" do
      @editor.mix.find_playlist_by_user_id("7").nil?
    end

end
