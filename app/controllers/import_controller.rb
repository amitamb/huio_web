class ImportController < ApplicationController
  require 'csv'

  before_action :authenticate_user!

  def index

  end

  def process_import
    file = params[:file]
    CSV.foreach(file.path, :headers => true) do |row|
      title, date = row["Title"], row["Date"]
      title_parts = title.split(": ")
      netflix_title = NetflixTitle.search_by_netflix_history(title_parts.join(" "))
      if netflix_title.present?
        current_user.add_to_history(netflix_title, date, title)
      end
    end
    redirect_back fallback_location: import_path
  end
end
