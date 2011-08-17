class Upload < ActiveRecord::Base
  has_attached_file :upload
  belongs_to :user
end