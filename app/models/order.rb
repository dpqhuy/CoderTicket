class Order < ApplicationRecord
	has_many :ticket_items

	validates :email, presence: true
	validates :phone_number, presence: true

	def update_ticket_types
		if ticket_items
			ticket_items.each do |item|
				item.ticket_type.update_attribute(:max_quantity, item.ticket_type.max_quantity - item.quantity)
			end
		end
	end
end
