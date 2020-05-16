FactoryBot.define do
  factory :user_selection do
    user_id {1}
    data {{:id=>31,
    :movies=>
     [{:title=>"Castaway",
       :role=>"Actor Dude",
       :release_date=>"2020-06-03",
       :description=>"Dude gets lost on island talks to ball.",
       :image=>"https://image.tmdb.org/t/p/w600_and_h900_bestv2/4x4puNUAqBpi9sUMYL5dNPSdB6I.jpg",
       :genres=>["Drama", "Music"]},
      {:title=>"Castaway2",
       :role=>"Actor Dude",
       :release_date=>"2020-06-04",
       :description=>"Dude gets lost on island again, talks to ball.",
       :image=>"https://image.tmdb.org/t/p/w600_and_h900_bestv2/4x4puNUAqBpi9sUMYL5dNPSdB6I.jpg",
       :genres=>["Drama", "Music"]}]}}
    # data { id: 31, movies:[
    #     { title: 'Castaway', 
    #     role: 'Actor Dude', 
    #     release_date: '2020-06-03', 
    #     description: 'Dude gets lost on island talks to ball.', 
    #     image: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/4x4puNUAqBpi9sUMYL5dNPSdB6I.jpg', 
    #     genres: ["Drama","Music"] }, 
    #   { title: 'Castaway2', 
    #     role: 'Actor Dude', 
    #     release_date: '2020-06-04', 
    #     description: 'Dude gets lost on island again, talks to ball.', 
    #     image: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/4x4puNUAqBpi9sUMYL5dNPSdB6I.jpg', 
    #     genres: ["Drama","Music"] }
    #       ]}
  end
end
