class Morphbank < ActiveRecord::Base
  
  belongs_to :species
  belongs_to :upload
  
end