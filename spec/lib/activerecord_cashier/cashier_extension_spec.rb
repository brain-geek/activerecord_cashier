require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe 'Cashier extension' do
  subject { Rails.cache }
  let(:adapter) { Cashier.adapter }
  let(:page) { Page.create! } 

  describe "#expire" do
    it "should work with AR model object as argument" do
      subject.write("foo", "bar", :tag => [page])

      subject.read('foo').should == 'bar'
      Cashier.expire(Page.find page.id)
      subject.read('foo').should be_nil
    end

    it "should work with AR model class as argument" do
      subject.write("foo", "bar", :tag => [Page])

      subject.read('foo').should == 'bar'
      Cashier.expire(Page)
      subject.read('foo').should be_nil
    end
  end

  describe "#tags" do
    it "returns all tags" do
      page
      subject.write("foo0", "bar")
      Cashier.tags.should be_empty

      subject.write("foo1", "bar", tag: 'asdasd')
      Cashier.tags.should =~ ['asdasd']

      subject.write("foo2", "bar", tag: Page)
      Cashier.tags.should =~ ['asdasd', Page]

      subject.write("foo3", "bar", tag: [page, 'ewq'])
      Cashier.tags.should =~ ['asdasd', Page, page, 'ewq']
    end
  end
end