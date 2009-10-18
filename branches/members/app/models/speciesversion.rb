class Speciesversion < ActiveRecord::Base
  belongs_to :user
  alias_attribute :sort, :sort_id
  alias_attribute :scamit, :scamit_id
  
  def return_user
    User.find(self.user_id).login
  end
  
end
