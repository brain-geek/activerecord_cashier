require "activerecord_cashier/version"

module ActiverecordCashier
  PREFIX = 'ar-cachier-'
  DELIMITER = '+-'

  class Railtie < ::Rails::Railtie
    initializer "activerecord_cashier" do |app|
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Base.send :include, ActiverecordCashier::ActiveRecordExtension
        ::Cashier.send :include, ActiverecordCashier::CashierExtension
      end
    end
  end

  class << self
    def morph(*tags)
      tags.flatten!

      tags.map do |tag|
        if tag.is_a? String
          tag
        elsif tag.is_a? Class
          PREFIX + tag.to_s
        elsif tag.is_a?(ActiveRecord::Base)
          "#{PREFIX}#{tag.class.to_s}#{DELIMITER}#{tag.try :id}"
        end          
      end.flatten
    end

    def demorph(*tags)
      tags.flatten!

      tags.map do |tag|
        if tag.index(PREFIX) == 0
          parts = tag[PREFIX.length..-1].split(DELIMITER)
          if parts.length == 1
            parts.first.constantize
          else parts.length == 2
            parts.first.constantize.find_by_id(parts.last.to_i)
          end
        else
          tag
        end
      end
    end
  end
end

require "activerecord_cashier/cashier_extension"
require "activerecord_cashier/active_record_extension"