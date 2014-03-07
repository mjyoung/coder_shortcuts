class Shortcut < ActiveRecord::Base
has_many :steps
has_many :tags, through: :shortcut_tags
end
