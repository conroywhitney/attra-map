require 'spec_helper'

describe Attra::Serp do

  context "sanity check" do

    it "should initialize" do
      expect { Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=4") }.to_not raise_error
    end

  end

  context "query string" do

    context "parsing" do

      before(:each) do
        @serp = Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=test-farm-name&City=test-city&State=test-state&Keyword=test-keyword&allDate=test-all-date&page=test-page")
      end

      it "should capture farm name" do
        expect(@serp.farm_name).to eq "test-farm-name"
      end

      it "should capture city" do
        expect(@serp.city).to eq "test-city"
      end

      it "should capture state" do
        expect(@serp.state).to eq "test-state"
      end

      it "should capture keyword" do
        expect(@serp.keyword).to eq "test-keyword"
      end

      it "should capture allDate" do
        expect(@serp.all_date).to eq "test-all-date"
      end

      it "should capture page" do
        expect(@serp.page).to eq "test-page"
      end

    end

  end

  context "pagination" do

    it "should handle no page number" do
      @serp = Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go")
      expect(@serp.next_url).to eq "https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=2"
    end

    it "should handle existing page number" do
      @serp = Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=2")
      expect(@serp.next_url).to eq "https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=3"
    end

  end

  context "valid" do

    it "should return true for normal page" do
      expect(Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=4").valid?).to eq true
    end

    it "should return false for high number page" do
      expect(Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=4000").valid?).to eq false
    end

  end

  context "listings" do

    before(:each) do
      @serp = Attra::Serp.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go")
    end

    it "should not error out" do
      expect { @serp.listings }.to_not raise_error
    end

    it "should return 15 listings" do
      expect(@serp.listings.size).to eq 15
    end

    it "should return urls" do
      expect(@serp.listings.first.include?("farmdetails.php")).to be true
    end

  end

end
