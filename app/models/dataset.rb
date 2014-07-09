class Dataset < ActiveRecord::Base
  has_many :datapoints
  # Remember to create a migration!
end
