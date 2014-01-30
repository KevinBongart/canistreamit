module Canistreamit
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method].freeze
    VALID_OPTIONS_KEYS    = [:format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT   = "http://www.canistream.it/services"
    DEFAULT_FORMAT     = :json
    DEFAULT_METHOD     = :get
    DEFAULT_USER_AGENT = "canistream.it API Ruby Gem #{Canistreamit::VERSION}".freeze

    # Build accessor methods for every config options so we can do this, for example:
    #   Canistreamit.format = :xml
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get "extended"
    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint   = DEFAULT_ENDPOINT
      self.format     = DEFAULT_FORMAT
      self.method     = DEFAULT_METHOD
      self.user_agent = DEFAULT_USER_AGENT
    end

    def configure
      yield self
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end
