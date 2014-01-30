require "helper"

describe Canistreamit::Client do
  before do
    @keys = Canistreamit::Configuration::VALID_CONFIG_KEYS
  end

  describe "with module configuration" do
    before do
      Canistreamit.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Canistreamit.reset
    end

    it "should inherit module configuration" do
      api = Canistreamit::Client.new
      @keys.each do |key|
        api.send(key).must_equal key
      end
    end

    describe "with class configuration" do
      before do
        @config = {
          :format     => "of",
          :endpoint   => "ep",
          :user_agent => "ua",
          :method     => "hm",
        }
      end

      it "should override module configuration" do
        api = Canistreamit::Client.new(@config)
        @keys.each do |key|
          api.send(key).must_equal @config[key]
        end
      end

      it "should override module configuration after" do
        api = Canistreamit::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          api.send("#{key}").must_equal @config[key]
        end
      end
    end
  end
end
