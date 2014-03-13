class Shortcut < ActiveRecord::Base
  has_many :steps, :dependent => :destroy

  has_many :shortcut_tags, :dependent => :destroy
  has_many :tags, through: :shortcut_tags

  accepts_nested_attributes_for :steps, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :tags, :reject_if => :all_blank, :allow_destroy => true
end
