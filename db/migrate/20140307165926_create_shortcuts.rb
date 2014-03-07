class CreateShortcuts < ActiveRecord::Migration
  def change
    create_table :shortcuts do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
