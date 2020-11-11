require_relative '../lib/scraper.rb'

describe Scraper do
  subject { Scraper.new('https://ebay', '.com') }
  let(:url) { 'https://www.ebay.com/sch/i.html?_from=R40&_nkw=watch' }
  describe '#initialize' do
    it 'initializes @base_url_left' do
      expect(subject.base_url_left).to eq('https://ebay')
      expect(subject.base_url_left).to_not eq('https://ebay.com')
    end
    it 'initializes @base_url_right' do
      expect(subject.base_url_right).to eq('.com')
      expect(subject.base_url_right).to_not eq('https://ebay.com')
    end
  end

  describe '#construct_url' do
    it 'generates a url by shoving the parameter between base_url left and right' do
      expect(subject.construct_url('parameter')).to_not eq('https://www.ebay.com/sch/i.html?_from=R40parameter&_sacat=0')
      expect(subject.construct_url('parameter')).to eq('https://ebayparameter.com')
    end
  end

  describe '#modify_url' do
    it 'updates and returns the url by adjusting the page number provided' do
      expect(subject.modify_url(url, 3)).to eq('https://www.ebay.com/sch/i.html?_from=R40&_nkw=watch&_pgn=3')
      expect(subject.modify_url(url, 3)).to_not eq('https://www.ebay.com/sch/i.html?_from=R40&_nkw=watch&_pgn=2')
    end
  end

  describe '#scrape' do
    it 'fetchs using the url provided and returns a nokogiri object built from the fetched HTML' do
      expect(subject.scrape(url).class).to eq(Nokogiri::XML::NodeSet)
      expect(subject.scrape(url).class).to_not eq(String)
    end
  end
end
