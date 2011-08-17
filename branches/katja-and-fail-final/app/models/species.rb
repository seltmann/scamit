class Species < ActiveRecord::Base
  alias_attribute :sort, :sort_id
  alias_attribute :scamit, :scamit_id
  
  has_many :versions, :class_name => 'Speciesversion', :foreign_key => :parent_id
  has_many :morphbanks
  has_many :synonyms
  has_many :samples
  
  def name
    (self.genus.nil? ? "" : self.genus ) + " " + (self.species.nil? ? "" : self.species)
  end
  
  
  def revisions_sorted
      versions = self.versions.sort{|x, y| y.updated_at <=> x.updated_at }
  end
  
  
  private

  def attributes_protected_by_default
    []
  end
  
end