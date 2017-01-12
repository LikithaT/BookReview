class Book < ApplicationRecord
	 max_paginates_per 50
	belongs_to :user
	belongs_to :category
	def category_name
		category.try(:name)
	end
def category_name=(name)
	self.category = category.find_or_create_by_name(name) if name.present?
		
	end
	

end