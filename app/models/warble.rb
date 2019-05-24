# == Schema Information
#
# Table name: warbles
#
#  id         :bigint(8)        not null, primary key
#  body       :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Warble < ApplicationRecord
  validates :body, :author_id, presence: true 

  belongs_to :author, # rails 5+ automatically validates presence of :author_id via writing this belongs_to :author method
    primary_key: :id, # column name in user table
    foreign_key: :author_id, #column name in warble table that reference user table
    class_name: :User 

  has_one :location, # returns the Location object; has_many returns Array-like object of multiple Location objects
    through: :author, 
    source: :location

  has_many :likes,
    primary_key: :id,
    foreign_key: :warble_id,
    class_name: :Like
end 
