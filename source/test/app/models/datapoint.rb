class Datapoint < ActiveRecord::Base
  belongs_to :dataset
  # Remember to create a migration!
end
