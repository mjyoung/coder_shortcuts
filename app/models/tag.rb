class Tag < ActiveRecord::Base
  has_many :shortcuts, through: :shortcut_tags
end
