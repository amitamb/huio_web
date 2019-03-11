class WatchedEntry < ApplicationRecord
  belongs_to :user
  belongs_to :netflix_title
end
