class Datapoints < ActiveRecord::Migration
    def change
    create_table :datapoints do |t|
      t.string :date
      t.string :value
      t.integer :dataset_id
    end
  end
end
