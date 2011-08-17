class Sample < ActiveRecord::Base
  belongs_to :species
  belongs_to :locality
end
