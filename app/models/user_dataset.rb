class UserDataset < ActiveRecord::Base
  belongs_to :user
  belongs_to :dataset
  # Remember to create a migration!
end
