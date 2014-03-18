class Shortcut < ActiveRecord::Base
  belongs_to :user
  has_many :steps, :dependent => :destroy

  has_many :shortcut_tags, :dependent => :destroy
  has_many :tags, through: :shortcut_tags

  accepts_nested_attributes_for :steps, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :tags, :reject_if => :all_blank, :allow_destroy => true

  def self.search(search)
    if search
      shortcuts = Shortcut.includes(:tags).where("tags.name LIKE ?", "%#{search}%").references(:tags)
    else
      scoped
    end
  end

end
