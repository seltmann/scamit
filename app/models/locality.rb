class Locality < ActiveRecord::Base
  has_many :samples
  has_many :species, :through => :samples
end