# == Schema Information
#
# Table name: avatars
#
#  id                :integer          not null, primary key
#  article_id        :integer
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Avatar < ActiveRecord::Base

  require 'open-uri'

  belongs_to :article

  has_attached_file :data, styles: {original: "200x200"}


  validates_attachment_content_type :data, :content_type => %w(image/jpg image/jpeg image/gif image/png image/x-png)
  validates_attachment_size :data, :less_than => 5.megabytes

  def url(*args)
    data.url(*args)
  end

  def path(*args)
    data.path(*args)
  end

  def name
    data_file_name
  end

  def content_type
    data_content_type
  end

  def file_size
    data_file_size
  end

end
