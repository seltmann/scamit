class Synonym < ActiveRecord::Base
  alias_attribute :old, :old_id
  alias_attribute :scamit, :scamit_id
  alias_attribute :specieslistsort, :specieslistsort_id
  
  has_many :versions, :class_name => 'Synonymversion', :foreign_key => :parent_id
  belongs_to :species
  
  def revisions_sorted
      versions = self.versions.sort{|x, y| y.updated_at <=> x.updated_at }
  end
  
end