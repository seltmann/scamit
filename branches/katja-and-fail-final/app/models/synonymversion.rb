class Synonymversion < ActiveRecord::Base
  belongs_to :user
  
  alias_attribute :old, :old_id
  alias_attribute :scamit, :scamit_id
  alias_attribute :specieslistsort, :specieslistsort_id
  
  def return_user
    User.find(self.user_id).login
  end
  
end