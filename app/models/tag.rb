class Tag < ActiveRecord::Base
  has_many :shortcut_tags
  has_many :shortcuts, through: :shortcut_tags
end
