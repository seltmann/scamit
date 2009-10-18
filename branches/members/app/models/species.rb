class Species < ActiveRecord::Base
  alias_attribute :sort, :sort_id
  alias_attribute :scamit, :scamit_id
  
  has_many :versions, :class_name => 'Speciesversion', :foreign_key => :parent_id
  
  def revisions_sorted
      versions = self.versions.sort{|x, y| y.updated_at <=> x.updated_at }
  end
  
end