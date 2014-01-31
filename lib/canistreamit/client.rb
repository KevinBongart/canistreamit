require "httparty"

module Canistreamit
  class Client
    include HTTParty

    # Define the same set of accessors as the Canistreamit module
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    base_uri Configuration::DEFAULT_ENDPOINT

    VALID_MEDIA_TYPES = ["streaming", "rental", "purchase", "dvd", "xfinity"].freeze

    def initialize(options = {})
      # Merge the config values from the module and those passed
      # to the client.
      merged_options = Canistreamit.options.merge(options)

      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def search(movie_name)
      response = self.class.get "/search", query: { movieName: movie_name }
      response.parsed_response
    end

    def query(movie_id, media_types = "streaming")
      media_types = array_of_unique_elements(media_types)
      return unless valid_media_types?(media_types)

      result = {}

      media_types.each do |media_type|
        response = self.class.get "/query", query: {
          movieId: movie_id,
          attributes: '1',
          mediaType: media_type
        }

        result[media_type] = response.parsed_response
      end

      result
    end

    def search_and_query(movie_name, media_types = "streaming", limit = 1)
      media_types = array_of_unique_elements(media_types)
      return unless valid_media_types?(media_types)

      response = search(movie_name)

      if response.any?
        response.first(limit).map do |movie|
          {
            "movie" => movie,
            "availability" => query(movie["_id"], media_types)
          }
        end
      else
        response
      end
    end

    private

    def array_of_unique_elements(array_or_element)
      Array(array_or_element).uniq
    end

    def valid_media_types?(media_types)
      (media_types - VALID_MEDIA_TYPES).empty?
    end
  end
end
