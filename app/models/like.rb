# == Schema Information
#
# Table name: likes
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  warble_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User 
  
  belongs_to :warble,
    primary_key: :id, 
    foreign_key: :warble_id, 
    class_name: :Warble 
end
