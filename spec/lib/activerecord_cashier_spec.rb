require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'Rails.cache integration' do
  before(:each) do
    Cashier.adapter = :redis_store
  end

  subject { Rails.cache }
  let(:adapter) { Cashier.adapter }

  describe "#expire" do
    let(:page) { Page.create! }
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

    it "should additionaly expire all instances if class is specified" do
      subject.write("foo", "bar", :tag => [page])

      subject.read('foo').should == 'bar'
      Cashier.expire(Page)
      subject.read('foo').should be_nil
    end
  end

  describe "#morph, #demorph" do
    it "should morph AR objects to strings" do
      source = [Page, Page.create!, 'page', 'page1', 'asdf']
      ActiverecordCashier.morph(source).any?{|a| a.is_a? String}.should be_true
    end

    it "should be able to demorph objects correctly" do
      source = [Page, Page.create!, 'page', 'page1', 'asdf']

      #it does not lose anything after demorph. It may have some additional stuff
      ActiverecordCashier.demorph(ActiverecordCashier.morph(source)).should include(*source)
    end
  end
end
