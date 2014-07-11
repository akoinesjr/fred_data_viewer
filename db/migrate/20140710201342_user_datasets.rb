class UserDatasets < ActiveRecord::Migration
  def change
      create_table :user_datasets do |t|
      t.integer :user_id
      t.integer :dataset_id
    end
  end
end
