class ShortcutTag < ActiveRecord::Base
  belongs_to :shortcut
  belongs_to :tag
end
