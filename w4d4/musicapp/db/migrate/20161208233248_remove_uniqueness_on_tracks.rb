class RemoveUniquenessOnTracks < ActiveRecord::Migration
  def change
    remove_index(:tracks, :name => 'index_tracks_on_album_id')
  end
end
