require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe 'AR integration' do
  subject { Rails.cache }
  let(:adapter) { Cashier.adapter }

  let(:page) { Page.create! name: 'first page'}
  let(:other_page) { Page.create! name: 'other page'}

  describe "on create" do
    it "expires if tagged as class" do
      subject.write('lorem', 'ip', tag: Page)
      subject.read('lorem').should == 'ip'

      Page.create!

      subject.read('lorem').should be_nil
    end

    it "does not expire if created" do
      subject.write('lorem', 'ipsum', tag: page)
      subject.read('lorem').should == 'ipsum'

      Page.create! name: 'third'

      subject.read('lorem').should == 'ipsum'
    end
  end

  describe "on update" do
    it "expires if tagged as class" do
      subject.write('lorem', 'ip', tag: Page)
      subject.read('lorem').should == 'ip'

      page.name = 'qwewq'
      page.save!

      subject.read('lorem').should be_nil
    end

    it "does not expire if other object touched" do
      subject.write('lorem', 'ipsum', tag: page)
      subject.read('lorem').should == 'ipsum'

      other_page.name = 'qwewq'
      other_page.save!

      subject.read('lorem').should == 'ipsum'
    end

    it "does expire if this object is touched" do
      subject.write('lorem', 'ipsum', tag: page)
      subject.read('lorem').should == 'ipsum'

      page.name = 'qwewq'
      page.save!

      subject.read('lorem').should be_nil
    end
  end

  describe "on delete" do
    it "expires if tagged as class" do
      subject.write('lorem', 'ip', tag: Page)
      subject.read('lorem').should == 'ip'

      page.destroy

      subject.read('lorem').should be_nil
    end

    it "does not expire if other object touched" do
      subject.write('lorem', 'ipsum', tag: page)
      subject.read('lorem').should == 'ipsum'

      other_page.destroy

      subject.read('lorem').should == 'ipsum'
    end

    it "does expire if this object is touched" do
      subject.write('lorem', 'ipsum', tag: page)
      subject.read('lorem').should == 'ipsum'

      page.destroy

      subject.read('lorem').should be_nil
    end
  end

  describe "#expire_all as class method" do
    it "deletes all tags for this class instances" do
      subject.write("foo", "bar", :tag => [page])
      subject.read('foo').should == 'bar'

      Page.expire_all_cache
      subject.read('foo').should be_nil
    end

    it "deletes everything marked as this class" do
      subject.write("foo", "bar", :tag => Page)

      subject.read('foo').should == 'bar'

      Page.expire_all_cache
      subject.read('foo').should be_nil      
    end

    it "does not deletes other objects, same as strings, etc." do
      subject.write("foo", "b", :tag => [User, 'page', 'Page', 'stuff', User.create!])

      subject.read('foo').should == 'b'

      Page.expire_all_cache
      subject.read('foo').should == 'b'
    end
  end
end