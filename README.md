# canistreamit

A Ruby wrapper for [canistream.it](http://www.canistream.it/) API inspired by [Niels Lemmens's Python wrapper](https://github.com/Bulv1ne/CanIStreamIt).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'canistreamit'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install canistreamit
```

## Usage

Create a new client:

```ruby
client = Canistreamit::Client.new
```

Search for movies by title:

```ruby
client.search("Everything is Illuminated")
=> [{"actors"=>"Elijah Wood, Eugene Hutz, Boris Leskin",
    "year"=>2005,
    "description"=>"",
    "title"=>"Everything is Illuminated",
    "image"=>"http://content7.flixster.com/movie/25/01/250121_det.jpg",
    "rating"=>3.3,
    "_id"=>"4ebdd5f9f5f807716100001b",
    "links"=>
     {"rottentomatoes"=>
       "http://www.rottentomatoes.com/m/everything_is_illuminated/",
      "imdb"=>"http://www.imdb.com/title/tt0404030/",
      "shortUrl"=>
       "http://www.canistream.it/search/movie/4ebdd5f9f5f807716100001b/everything-is-illuminated"}}]
```

Query canistream.it by movie id and media type:

```ruby
client.query("4ebdd5f9f5f807716100001b", ["rental", "streaming"])
=> {"rental"=>
    {"apple_itunes_rental"=>
      {"url"=>"http://www.canistream.it/link/go/4f33decdf5f8073e10000025",
       "price"=>3.99,
       "external_id"=>293314469,
       "date_checked"=>1391095519,
       "direct_url"=>
        "http://click.linksynergy.com/fs-bin/click?id=g0LjNrUM/ms&subid=&offerid=146261.1&type=10&tmpid=3909&RD_PARM1=https%3A%2F%2Fitunes.apple.com%2Fus%2Fmovie%2Feverything-is-illuminated%2Fid293314469%3Fuo%3D4",
       "time"=>0,
       "friendlyName"=>"Apple iTunes Rental",
       "cache"=>true},
     "youtube_rental"=>
      {"url"=>"http://www.canistream.it/link/go/4f33decdf5f8073e10000027",
       "price"=>"1.99",
       "external_id"=>"KdHNp9FPGG8",
       "date_checked"=>1391118942,
       "direct_url"=>
        "http://www.youtube.com/watch?v=KdHNp9FPGG8&feature=youtube_gdata_player",
       "time"=>0,
       "friendlyName"=>"Youtube Rental",
       "cache"=>true},
     "android_rental"=>
      {"url"=>"http://www.canistream.it/link/go/4f47c662f5f8076d43000001",
       "price"=>1.99,
       "external_id"=>"movie-KdHNp9FPGG8",
       "date_checked"=>1391095520,
       "direct_url"=>
        "https://play.google.com/store/movies/details/Everything_is_Illuminated?id=KdHNp9FPGG8",
       "time"=>0,
       "friendlyName"=>"Google Play Rental",
       "cache"=>true}},
   "streaming"=>
    {"hitbliss_streaming"=>
      {"url"=>"http://www.canistream.it/link/go/5297e955f5f807dd7fb627bf",
       "price"=>0,
       "external_id"=>
        "http://www.hitbliss.com/movies/Everything-Is-Illuminated.html?utm_source=canistreamit&utm_medium=feed&utm_campaign=tv-movies",
       "date_checked"=>1391095487,
       "direct_url"=>
        "http://www.hitbliss.com/movies/Everything-Is-Illuminated.html?utm_source=canistreamit&utm_medium=feed&utm_campaign=tv-movies",
       "time"=>0,
       "friendlyName"=>"Hitbliss Streaming",
       "cache"=>true}}}
```

Available media types:
- streaming (default)
- rental
- purchase
- dvd
- xfinity

Because each media type will result in one slow request to canistream.it API,
avoid including more types than you care for.

You can also query canistream.it for all search results at once:

```ruby
client.search_and_query("die hard", ["rental", "streaming"])
=> [{"movie"=>
     {"actors"=>"Bruce Willis, Justin Long, Timothy Olyphant",
      "year"=>2007,
      "description"=>"",
      "title"=>"Live Free or Die Hard",
      "image"=>"http://content8.flixster.com/movie/10/93/34/10933482_det.jpg",
      "rating"=>4.05,
      "_id"=>"4e65e608f5f8073663000000",
      "links"=>
       {"imdb"=>"http://www.imdb.com/title/tt0337978/",
        "rottentomatoes"=>
         "http://www.rottentomatoes.com/m/live_free_or_die_hard/",
        "shortUrl"=>
         "http://www.canistream.it/search/movie/4e65e608f5f8073663000000/live-free-or-die-hard"}},
    "availability"=>
     {"rental"=>
       {"apple_itunes_rental"=>
         {"url"=>"http://www.canistream.it/link/go/4f1ba3dcf5f807036000006f",
          "price"=>2.99,
          "external_id"=>279609666,
          "date_checked"=>1391065570,
          "direct_url"=>
           "http://click.linksynergy.com/fs-bin/click?id=g0LjNrUM/ms&subid=&offerid=146261.1&type=10&tmpid=3909&RD_PARM1=https%3A%2F%2Fitunes.apple.com%2Fus%2Fmovie%2Flive-free-or-die-hard-unrated%2Fid279609666%3Fuo%3D4",
          "time"=>0,
          "friendlyName"=>"Apple iTunes Rental",
          "cache"=>true},
        "youtube_rental"=>
         {"url"=>"http://www.canistream.it/link/go/5096bb04f5f807d313000008",
          "price"=>"2.99",
          "external_id"=>"WXPPz8-6IOk",
          "date_checked"=>1391065568,
          "direct_url"=>
           "http://www.youtube.com/watch?v=WXPPz8-6IOk&feature=youtube_gdata_player",
          "time"=>0,
          "friendlyName"=>"Youtube Rental",
          "cache"=>true}},
      "streaming"=>
       {"hitbliss_streaming"=>
         {"url"=>"http://www.canistream.it/link/go/528f9102f5f807fb39579006",
          "price"=>0,
          "external_id"=>
           "http://www.hitbliss.com/movies/Live-Free-or-Die-Hard.html?utm_source=canistreamit&utm_medium=feed&utm_campaign=tv-movies",
          "date_checked"=>1391065571,
          "direct_url"=>
           "http://www.hitbliss.com/movies/Live-Free-or-Die-Hard.html?utm_source=canistreamit&utm_medium=feed&utm_campaign=tv-movies",
          "time"=>0,
          "friendlyName"=>"Hitbliss Streaming",
          "cache"=>true}}}}]
```

Because this is pretty heavy on canistream.it API,
`search_and_query` only queries for the first search result by default.
You can set your own limit with a third parameter, but be responsible:

```ruby
client.search_and_query("die hard", "rental", 5)
```

## Contributing

1. Fork it (http://github.com/KevinBongart/canistreamit/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
