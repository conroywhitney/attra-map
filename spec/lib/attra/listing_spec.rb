require 'spec_helper'

describe Attra::Listing do

  ROGUE_FARMS = "https://attra.ncat.org/attra-pub/internships/farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391"

  context "sanity check" do

    it "should initialize" do
      expect { Attra::Listing.new(ROGUE_FARMS) }.to_not raise_error
    end

  end

  context "initialization" do
    context "url" do

      before(:each) do
        @listing = Attra::Listing.new(ROGUE_FARMS)
      end

      it "should add on directory if not included" do
        url = "farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391"
        expect(Attra::Listing.new(url).url).to eq ROGUE_FARMS
      end

      it "should not add on directory if already included" do
        url = "attra-pub/internships/farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391"
        expect(Attra::Listing.new(url).url).to eq ROGUE_FARMS
      end

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

  context "attribute from element" do

    before(:each) do
      @listing = Attra::Listing.new(ROGUE_FARMS)
    end

    it "should handle perfectly clean" do
      expect(@listing.get_attribute_from_element("App Deadline")).to eq :app_deadline
    end

    it "should handle whitespace no colon" do
      expect(@listing.get_attribute_from_element("Minimum Length of Stay ")).to eq :minimum_stay_length
    end

    it "should handle colon no whitespace" do
      expect(@listing.get_attribute_from_element("Housing:")).to eq :housing
    end

    it "should handle whitespace and colon" do
      expect(@listing.get_attribute_from_element("Website: ")).to eq :website
    end

  end

  context "parse_address" do

    before(:each) do
      @listing = Attra::Listing.new(ROGUE_FARMS)
    end

    it "should set the address attribute" do
      @listing.parse_address("123 Fake St")
      expect(@listing.address).to eq "123 Fake St"
    end

    it "should trim newlines" do
      @listing.parse_address("\nPO Box 533\n")
      expect(@listing.address).to eq "PO Box 533"
    end

  end

  context "parse_city_state_zip" do

    before(:each) do
      @listing = Attra::Listing.new(ROGUE_FARMS)
    end

    context "in a perfect world" do
      before(:each) do
        @listing.parse_city_state_zip("Asheville, NC 28803")
      end

      it "should set the city attribute" do
        expect(@listing.city).to eq "Asheville"
      end

      it "should set the state attribute" do
        expect(@listing.state).to eq "NC"
      end

      it "should set the zip attribute" do
        expect(@listing.zip).to eq "28803"
      end
    end

  end

  context "full address" do
    before(:each) do
      @listing = Attra::Listing.new(ROGUE_FARMS)
      @listing.crawl!
    end

    it "should concatenate address and city when there" do
      expect(@listing.full_address).to eq "PO Box 533, Ashland, OR, 97520"
    end
  end

  context "concatenate_attribute" do

    before(:each) do
      @listing = Attra::Listing.new(ROGUE_FARMS)
    end

    it "should handle nil initially" do
      @listing.website = nil
      @listing.concatenate_attribute(:website, "testing")
      expect(@listing.website).to eq "testing"
    end

    it "should handle blank initially" do
      @listing.website = ""
      @listing.concatenate_attribute(:website, "testing")
      expect(@listing.website).to eq "testing"
    end

    it "should handle multiples" do
      @listing.website = nil
      @listing.concatenate_attribute(:website, "testing")
      @listing.concatenate_attribute(:website, "one")
      @listing.concatenate_attribute(:website, "two")
      @listing.concatenate_attribute(:website, "three")
      expect(@listing.website).to eq "testing one two three"
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

    it "should set title" do
      expect(@listing.title).to eq "Rogue Farm Corps- FarmsNOW Program"
    end

    it "should set address" do
      expect(@listing.address).to eq "PO Box 533"
    end

    it "should set city" do
      expect(@listing.city).to eq "Ashland"
    end

    it "should set state" do
      expect(@listing.state).to eq "OR"
    end

    it "should set zip" do
      expect(@listing.zip).to eq "97520"
    end

  end

end
