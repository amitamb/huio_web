FactoryBot.define do
  factory :watched_entry do
    user { nil }
    netflix_title { nil }
    watched_at { "2019-03-12 04:39:58" }
    history_entry { "MyText" }
  end
end
