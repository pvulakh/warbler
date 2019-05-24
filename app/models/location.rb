# == Schema Information
#
# Table name: locations
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord
  validates :name, presence: true

  has_many :users, # up to us what we call this method
    primary_key: :id, 
    foreign_key: :location_id,
    class_name: :User

  has_many :warbles,
    through: :users, # use Location#users association to get to the User model
    source: :warbles # user Warbles association in User model
end 
