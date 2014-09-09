class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url
      t.string :name
      t.integer :var1
      t.string :var2

      t.timestamps
    end
  end
end
