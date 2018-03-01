class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, 
										length: { minimum: 5 }

	def self.search(search)
	  if search
	    self.where('title LIKE ? OR text LIKE ?', "%#{search}%", "%#{search}%")
	  else
	    self
	  end
	end
end