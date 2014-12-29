require 'spec_helper'

describe Attra::Listing do

  ROGUE_FARMS = "https://attra.ncat.org/attra-pub/internships/farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391"

  context "sanity check" do

    it "should initialize" do
      expect { Attra::Listing.new(ROGUE_FARMS) }.to_not raise_error
    end

  end

end
