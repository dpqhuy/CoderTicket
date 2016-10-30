class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
  	return Event.where("starts_at >= ? AND published_at IS NOT NULL", DateTime.now)
  end

  def self.search(query)
  	return Event.where("name ILIKE ?", "%#{query}%")
  end

  def published?
  	return !published_at.nil?
  end

end
