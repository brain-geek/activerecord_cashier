module ActiverecordCashier
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods
      def inherited(kls)
        kls.send(:include, ActiverecordCashier::ActiveRecordModelExtension) if kls.superclass == ActiveRecord::Base
        super
      end      
    end

    included do
      # Existing subclasses pick up the model extension as well
      self.descendants.each do |kls|
        kls.send(:include, ActiverecordCashier::ActiveRecordModelExtension) if kls.superclass == ActiveRecord::Base
      end
    end
  end

  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      after_commit do |model| 
        Cashier.expire(model, model.class)
      end
    end

    module ClassMethods
      def expire_all_cache
        search_string = ActiverecordCashier::PREFIX + self.to_s + ActiverecordCashier::DELIMITER

        # using both 'original' functions for performance - morph-demorph with SQL queries will take lot of time
        Cashier.original_expire(*Cashier.original_tags.find_all{|key| key.index(search_string) == 0 })

        Cashier.expire self
      end
    end      
  end
end
