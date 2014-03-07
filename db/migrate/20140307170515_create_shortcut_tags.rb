class CreateShortcutTags < ActiveRecord::Migration
  def change
    create_table :shortcut_tags do |t|
      t.references :shortcut, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
