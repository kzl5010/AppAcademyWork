# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_id   :integer          not null
#  ord        :integer          not null
#  bonus      :boolean          default("false"), not null
#  lyrics     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album, source: :band

  validates :album_id, :lyrics, :name, :ord, presence: true
  validates :bonus, inclusion: { in: [true, false] }
  validates :ord, uniqueness: true
end
