class Film
  include Neo4j::ActiveNode

  property :name
  property :release_year
  property :language

  # has_many :out, :friends, type: :friends_with, model_class: 'User'
  # has_one :in,   :github_profile, type: :linked_to  # model_class: 'GithubProfile' assumed
end
