class ImportController < ApplicationController
  require 'csv'

  def index

  end

  def process_import
    file = params[:file]
    CSV.foreach(file.path, :headers => true) do |row|
      title, date = row["Title"], row["Date"]
      title_parts = title.split(": ")
      res = NetflixTitle.search_by_netflix_history(title_parts.join(" "))
      if res
        
      end
    end
    redirect_back fallback_location: import_path
  end
end
