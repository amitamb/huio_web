class NetflixTitle < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  serialize :aliases, Array

  settings do
    mappings dynamic: false do
      indexes :id, type: :integer
      indexes :name, type: :string, analyzer: :english
      indexes :description, type: :string, analyzer: :english
      indexes :aliases, analyzer: :english # array
      indexes :wiki_title, type: :string, analyzer: :english
      # indexes :parent_sku, type: :keyword
      # indexes :status, type: :integer
      # indexes :site_type, type: :integer
      # indexes :website_delete, type: :integer
      # indexes :styles do
      #   indexes :id,   type: :integer
      #   indexes :website_delete, type: :integer
      # end
      # indexes :sizes do
      #   indexes :id,   type: :integer
      #   indexes :quantity, type: :integer
      # end
    end
  end

  def as_indexed_json(options = {})
    self.as_json(
      options.merge(
        only: [:id, :name, :description, :aliases, :wiki_title] #,
        # include: {
        #   sizes: { only: [:id, :quantity] },
        #   styles: { only: [:id, :website_delete] }
        # }
      )
    )
  end

  def self.search_by_netflix_history(history_title)
    title_parts = history_title.split(": ")
    res = NetflixTitle.search(NetflixTitle.sanitize_string_for_elasticsearch_string_query(title_parts.join(" ")))
    first_res = res.first
    matched_netflix_title = nil
    if first_res && first_res._score > 1
      matched_netflix_title = res.records.first
    end
    matched_netflix_title
  end

  private

  def self.sanitize_string_for_elasticsearch_string_query(str)
    # Escape special characters
    # http://lucene.apache.org/core/old_versioned_docs/versions/2_9_1/queryparsersyntax.html#Escaping Special Characters
    escaped_characters = Regexp.escape('\\/+-&|!(){}[]^~*?:')
    str = str.gsub(/([#{escaped_characters}])/, '\\\\\1')

    # AND, OR and NOT are used by lucene as logical operators. We need
    # to escape them
    ['AND', 'OR', 'NOT'].each do |word|
      escaped_word = word.split('').map {|char| "\\#{char}" }.join('')
      str = str.gsub(/\s*\b(#{word.upcase})\b\s*/, " #{escaped_word} ")
    end

    # Escape odd quotes
    quote_count = str.count '"'
    str = str.gsub(/(.*)"(.*)/, '\1\"\3') if quote_count % 2 == 1

    str
  end
end
