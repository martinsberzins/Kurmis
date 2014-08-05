class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.string :requirements
      t.string :costs
      t.float :support
      t.text :examples
      t.integer :price
      t.date :next_time_from
      t.date :next_time_to
      t.text :conditions
      t.string :administrator

      t.timestamps
    end
  end
end
