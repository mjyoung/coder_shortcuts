class ShortcutTag < ActiveRecord::Base
  belongs_to :shortcut
  belongs_to :tag

  accepts_nested_attributes_for :tag, :reject_if => :all_blank

end
