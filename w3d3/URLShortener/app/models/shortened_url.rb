class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, :presence=>true

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :visits,
  primary_key: :id,
  foreign_key: :short_id,
  class_name: :Visit

  has_many :visitors,
  Proc.new { distinct },
  through: :visits,
  source: :user


  def self.random_code
    a = SecureRandom.urlsafe_base64
    while exists?(a)
      a = SecureRandom.urlsafe_base64
    end
    a
  end

  def self.create_for_user_and_long_url!(user, long_url)
    a = ShortenedUrl.create!(:user_id=>user.id, :long_url=>long_url, :short_url=>ShortenedUrl.random_code)
    a.save
  end

  def num_clicks
    Visit.all.select(:id).where('short_id = ?', self.id).count
  end

  def num_uniques
    visitors.length
    # Visit.all.select(:user_id).where('short_id = ?', self.id).distinct.count
  end

  def num_recent_uniques
    time_limit = 10.minutes.ago
    Visit.all.select(:user_id).where('short_id = ? AND updated_at > ?', self.id, time_limit).distinct.count
  end
end
