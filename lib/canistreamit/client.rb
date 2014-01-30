require "httparty"

module Canistreamit
  class Client
    include HTTParty

    # Define the same set of accessors as the Canistreamit module
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    base_uri Configuration::DEFAULT_ENDPOINT

    def initialize(options={})
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

    def query(movie_id, media_type)
      response = self.class.get "/query", query: {
        movieId: movie_id,
        attributes: '1',
        mediaType: media_type
      }

      response.parsed_response
    end
  end
end
