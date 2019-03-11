class CreateNetflixTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :netflix_titles do |t|
      t.string :wikidata_id
      t.string :name
      t.text :description
      t.text :aliases
      t.string :fb_id
      t.string :imdb_id
      t.string :nf_id
      t.string :wiki_title

      t.timestamps
    end
    add_index :netflix_titles, :wikidata_id
    add_index :netflix_titles, :name
    add_index :netflix_titles, :description
    add_index :netflix_titles, :fb_id
    add_index :netflix_titles, :imdb_id
    add_index :netflix_titles, :nf_id
    add_index :netflix_titles, :wiki_title
  end
end
