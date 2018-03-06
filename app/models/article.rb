class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, 
										length: { minimum: 5 }

	has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by!(name: name).articles
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

	def self.search(search)
	  if search
	    self.where('title ILIKE ? OR text ILIKE ?', "%#{search}%", "%#{search}%")
	  else
	    self
	  end
	end
end
