# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord
  validates :name, presence: true

  has_many :users,
    primary_key: :id,
    foreign_key: :location_id,
    class_name: :User
  
  # need to define the through association :users before the has_many association that relies on it
  # otherwise, :users would not be defined when :flips was defined
  has_many :flips,
    through: :users, # through associations must be defined within the same class
    source: :authored_flips
    
end
