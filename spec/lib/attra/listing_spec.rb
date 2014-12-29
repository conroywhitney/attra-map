require 'spec_helper'

describe Attra::Listing do

  ROGUE_FARMS = "https://attra.ncat.org/attra-pub/internships/farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391"

  context "sanity check" do

    it "should initialize" do
      expect { Attra::Listing.new(ROGUE_FARMS) }.to_not raise_error
    end

  end

  context "query string" do
    context "parsing" do

      before(:each) do
        @listing = Attra::Listing.new(ROGUE_FARMS)
      end

      it "should capture attra id" do
        expect(@listing.attra_id).to eq "3391"
      end

    end
  end

  context "crawling" do

    before(:each) do
      @listing = Attra::Listing.new(ROGUE_FARMS)
      @listing.crawl!
    end

    it "should not error out" do
      expect { @listing.crawl! }.to_not raise_error
    end

    it "should actually find content" do
      expect(@listing.title).to eq "Rogue Farm Corps- FarmsNOW Program"
    end

  end

end
