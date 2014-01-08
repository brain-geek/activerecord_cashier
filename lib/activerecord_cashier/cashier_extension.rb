module ActiverecordCashier
  module CashierExtension
    extend ActiveSupport::Concern
    included do
      class << self
        alias_method :original_store_fragment, :store_fragment
        alias_method :original_expire, :expire
      
        def store_fragment(fragment, *tags)
          original_store_fragment(fragment, *ActiverecordCashier.morph(*tags))
        end

        def expire(*tags)
          original_expire(*ActiverecordCashier.morph(*tags))
        end
      end
    end
  end
end