describe "configuration" do
  after do
    Canistreamit.reset
  end

  describe ".configure" do
    Canistreamit::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        Canistreamit.configure do |config|
          config.send("#{key}=", key)
          Canistreamit.send(key).must_equal key
        end
      end
    end
  end

  Canistreamit::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it "should return the default value" do
        Canistreamit.send(key).must_equal Canistreamit::Configuration.const_get("DEFAULT_#{key.upcase}")
      end
    end
  end
end
