class Tag < ActiveRecord::Base
  has_many :shortcut_tags
  has_many :shortcuts, through: :shortcut_tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
