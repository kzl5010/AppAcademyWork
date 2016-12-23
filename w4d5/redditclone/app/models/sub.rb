# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string           not null
#

class Sub < ActiveRecord::Base
  validates :description, :name, :user_id, presence: true
  validates :name, uniqueness: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :post_subs, inverse_of: :sub, dependent: :destroy
  has_many :posts, through: :post_subs, source: :post

end
