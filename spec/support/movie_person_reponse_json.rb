# frozen_string_literal: true

module MoviePersonResponseJSON
  def movie_person_response_json
    {
      "page": 1,
      "total_results": 1,
      "total_pages": 1,
      "results": [
        {
          "popularity": 13.974,
          "known_for_department": 'Acting',
          "name": 'Tom Hanks',
          "id": 31,
          "profile_path": "\/2gY92j2lkNHL2cThBhPmgXLd5PL.jpg",
          "adult": false,
          "known_for": [
            {
              "poster_path": "\/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg",
              "vote_count": 17_813,
              "video": false,
              "media_type": 'movie',
              "id": 13,
              "adult": false,
              "backdrop_path": "\/7c9UVPPiTPltouxRVY6N9uugaVA.jpg",
              "original_language": 'en',
              "original_title": 'Forrest Gump',
              "genre_ids": [
                35,
                18,
                10_749
              ],
              "title": 'Forrest Gump',
              "vote_average": 8.4,
              "overview": 'A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.',
              "release_date": '1994-07-06'
            },
            {
              "poster_path": "\/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg",
              "vote_count": 12_271,
              "video": false,
              "media_type": 'movie',
              "id": 862,
              "adult": false,
              "backdrop_path": "\/lxD5ak7BOoinRNehOCA85CQ8ubr.jpg",
              "original_language": 'en',
              "original_title": 'Toy Story',
              "genre_ids": [
                16,
                35,
                10_751
              ],
              "title": 'Toy Story',
              "vote_average": 7.9,
              "overview": "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene. Afraid of losing his place in Andy's heart, Woody plots against Buzz. But when circumstances separate Buzz and Woody from their owner, the duo eventually learns to put aside their differences.",
              "release_date": '1995-10-30'
            },
            {
              "vote_count": 10_135,
              "id": 857,
              "video": false,
              "media_type": 'movie',
              "vote_average": 8.1,
              "title": 'Saving Private Ryan',
              "release_date": '1998-07-24',
              "original_language": 'en',
              "original_title": 'Saving Private Ryan',
              "genre_ids": [
                18,
                36,
                10_752
              ],
              "backdrop_path": "\/hjQp148VjWF4KjzhsD90OCMr11h.jpg",
              "adult": false,
              "overview": 'As U.S. troops storm the beaches of Normandy, three brothers lie dead on the battlefield, with a fourth trapped behind enemy lines. Ranger captain John Miller and seven men are tasked with penetrating German-held territory and bringing the boy home.',
              "poster_path": "\/JC8KQ2BXaAIFEU8zEuakiwUQSr.jpg"
            }
          ],
          "gender": 2
        }
      ]
    }
  end
end
