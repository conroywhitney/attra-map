require 'spec_helper'

describe Adapters::Listings::Algolia do

  before(:each) do
    karnes             = FactoryGirl.create(:kfi_land_for_sale)
    @listing           = Adapters::Listing.for(karnes)
    @algolia           = Adapters::Listings::Algolia.new(karnes)
    @locomotive        = Adapters::Listings::Locomotive.new(karnes)

    @for_sale          = @algolia
    @for_lease         = Adapters::Listings::Algolia.new(FactoryGirl.create(:kfi_retail_for_lease))
    @for_sale_or_lease = Adapters::Listings::Algolia.new(FactoryGirl.create(:kfi_office_for_sale_or_lease))
  end

  context "interface" do
    it "should completely implement the interface" do
      expect(@algolia.implements_interface?).to be true
    end
  end

  context "custom search attributes" do

    it "should respond to 'id'" do
      expect(@algolia.id).to eq(@listing.id)
    end

    it "should respond to 'permalink'" do
      expect(@algolia.permalink).to eq(@locomotive.permalink)
    end

    it "should respond to 'address'" do
      expect(@algolia.address).to eq(@listing.address_long)
    end

=begin
    it "should respond to 'listed_on_i'" do
      expect(@algolia.listed_on_i).to eq(1415077200)
    end
=end

  end

  context "attribute passthru" do

    it "should respond to 'listing_id'" do
      expect(@algolia.listing_id).to eq(@listing.listing_id)
    end

    it "should respond to 'title'" do
      expect(@algolia.title).to eq(@listing.title)
    end

    it "should respond to 'lat'" do
      expect(@algolia.lat).to eq(@listing.lat)
    end

    it "should respond to 'lon'" do
      expect(@algolia.lon).to eq(@listing.lon)
    end

  end

end



