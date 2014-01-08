require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'Cashier' do
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
