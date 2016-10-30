class TicketType < ActiveRecord::Base
  belongs_to :event

  has_many :ticket_items

  validates :max_quantity, uniqueness: {scope: [:event, :price, :name]}
end
