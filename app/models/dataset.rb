class Dataset < ActiveRecord::Base
  has_many :datapoints
  has_many :user_datasets
  has_many :users, :through => :user_datasets
  # Remember to create a migration!
end
