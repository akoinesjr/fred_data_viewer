class Datasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :name
    end
  end
end
