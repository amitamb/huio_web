class CreateWatchedEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :watched_entries do |t|
      t.references :user, foreign_key: true
      t.references :netflix_title, foreign_key: true
      t.datetime :watched_at
      t.text :history_entry

      t.timestamps
    end
    add_index :watched_entries, :history_entry
  end
end
