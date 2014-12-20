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

    it "should give next url" do
    end

  end

end
