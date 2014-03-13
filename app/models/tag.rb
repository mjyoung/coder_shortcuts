class Tag < ActiveRecord::Base
  has_many :shortcut_tags
  has_many :shortcuts, through: :shortcut_tags

  before_validation :tag_downcase
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private
    def tag_downcase
      self.name.downcase!
    end

end
