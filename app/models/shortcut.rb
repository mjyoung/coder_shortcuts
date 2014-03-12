class Shortcut < ActiveRecord::Base
has_many :steps, :dependent => :destroy
has_many :shortcut_tags
has_many :tags, through: :shortcut_tags

accepts_nested_attributes_for :steps
accepts_nested_attributes_for :tags
end
