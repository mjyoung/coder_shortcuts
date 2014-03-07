class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.references :shortcut, index: true
      t.integer :step_number
      t.text :text
      t.string :image_url

      t.timestamps
    end
  end
end
