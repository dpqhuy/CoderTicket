class TicketItem < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :order

  validates :order, presence: true
  validates :ticket_type, presence: true
  validates :quantity, :numericality => { :less_than_or_equal_to => 10 }
  validate :quantity_less_than_max_quantity_of_ticket_type

  after_save :update_ticket_type_max_quantity

  def quantity_less_than_max_quantity_of_ticket_type
    if ticket_type and ticket_type.max_quantity < quantity
      errors.add(:quantity, "quantity is larger than max_quantity of ticket_type")
    end
  end

  def update_ticket_type_max_quantity
    ticket_type.update_attribute(:max_quantity, ticket_type.max_quantity - quantity)
  end

end
