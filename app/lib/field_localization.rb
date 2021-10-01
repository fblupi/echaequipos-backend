module FieldLocalization
  DEFAULT_LANGUAGE_CODE = 'en'.freeze

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def has_field_localization(localized_fields)
      localized_fields.each do |localized_field|
        send :define_method, localized_field.to_s do
          case I18n.locale
          when :en
            if send("#{localized_field}_en").blank?
              send("#{localized_field}_es")
            else
              send("#{localized_field}_en")
            end
          when :es
            if send("#{localized_field}_es").blank?
              send("#{localized_field}_en")
            else
              send("#{localized_field}_es")
            end
          else
            send("#{localized_field}_#{DEFAULT_LANGUAGE_CODE}")
          end
        end
      end
    end
  end
end
