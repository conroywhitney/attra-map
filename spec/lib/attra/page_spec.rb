require 'spec_helper'

describe Attra::Page do

  context "sanity check" do

    it "should initialize" do
      expect { Attra::Page.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=4") }.to_not raise_error
    end

  end

  context "initialization" do
    it "should add domain on if not already there" do
      url = "farmdetails.php?FarmName=&City=&State=&Keyword=&allDate=1&page=1&FarmID=3250"
      expect(Attra::Page.new(url).url).to eq "https://attra.ncat.org/#{url}"
    end

    it "should not add domain if already there" do
      url = "https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=2"
      expect(Attra::Page.new(url).url).to eq url
    end
  end

  context "uri" do

    before(:each) do
      @page = Attra::Page.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=2")
    end

    it "should return a URI object" do
      expect(@page.uri.class).to eq URI::HTTPS
    end

    it "should become a url string again" do
      expect(@page.uri.to_s).to eq @page.url
    end

  end

  context "url splits base/path" do

    before(:each) do
      @page = Attra::Page.new("https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go")
    end

    it "should find base_url" do
      expect(@page.base_url).to eq "https://attra.ncat.org"
    end

    it "should find path" do
      expect(@page.path).to eq "/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go"
    end

  end

end

