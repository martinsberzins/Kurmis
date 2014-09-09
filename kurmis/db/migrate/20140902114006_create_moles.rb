class CreateMoles < ActiveRecord::Migration
  def change
    create_table :moles do |t|
      t.string :name
      t.integer :score
      t.string :avatar

      t.timestamps
    end
  end
end
