class User < ApplicationRecord

  has_many :watched_entries

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def admin?
    false
  end

  def add_to_history(netflix_title, date_str, entry)
    self.watched_entries.where(netflix_title_id: netflix_title.id).first_or_create({
      watched_at: Date.strptime(date_str, "%m/%d/%y"),
      history_entry: entry
    })
  end

end
