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
client.query("4ebdd5f9f5f807716100001b", "rental")
=> {"apple_itunes_rental"=>
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
     "cache"=>true}
```

Available media types:
- streaming
- rental
- purchase
- dvd
- xfinity

## Contributing

1. Fork it (http://github.com/KevinBongart/canistreamit/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
