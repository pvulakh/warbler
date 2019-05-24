class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true # prevents initializing an instance of ApplicationRecord itself
end

