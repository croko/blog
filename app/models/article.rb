# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  subject      :string(255)
#  body         :text
#  user_id      :integer
#  datafile_url :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Article < ActiveRecord::Base
  belongs_to :user
  has_one :avatar, dependent: :destroy

  validates :subject, :body, presence: true
  validates :datafile_url, format: URI::regexp(%w(http https)), allow_blank: true

  after_save :process_avatar

  protected

  def process_avatar
    unless datafile_url.blank?
      av = build_avatar
      av.data = open(datafile_url)
      av.save
    end
  end
end
