class ApplicationRecord < ActiveRecord::Base
  include FieldLocalization
  self.abstract_class = true
end
