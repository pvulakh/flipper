# == Schema Information
#
# Table name: flips
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#

class Flip < ApplicationRecord
  validates :body, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id, # here, primary_key is on the other table (users)
    class_name: :User

  has_one :location,
    through: :author,
    source: :location
  
  has_many :likes,
    primary_key: :id, # here, primary_key is on the current table (flips)
    foreign_key: :flip_id,
    class_name: :Like
  
  has_many :likers,
    through: :likes,
    source: :user
    
end
