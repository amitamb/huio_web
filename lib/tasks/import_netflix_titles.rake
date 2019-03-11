namespace :import do
  task :netflix_titles => :environment do
    line_num=0
    File.open(Rails.root + 'tmp/output.json').each do |line|
      line_num += 1
      print "#{line_num} #{line}" if line_num % 1000 == 0

      hash = JSON.parse(line)

      nt = NetflixTitle.where(wikidata_id: hash['id']).first_or_create!(
        name: hash['name'],
        description: hash['description'],
        aliases: hash['aliases'],
        fb_id: hash['freebaseId'],
        imdb_id: hash['imdbId'],
        nf_id: hash['netflixId'],
        wiki_title: hash['enwikiTitle']
      )

      p nt.errors if nt.errors.present?

      # break
      # return
      # puts line
    end
  end
end
