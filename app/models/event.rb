class Event < ApplicationRecord
  scope :past, -> { where("event_date < ?", DateTime.current) }
  scope :upcoming, -> { where("event_date >= ?", DateTime.current) }
  
  validates :event_date, presence: true
  validates :title, length: { minimum: 3 }, presence: true
  validates :details, length: { minimum: 10 }, presence: true
  
  belongs_to :creator, class_name: "User"

  has_many :event_attendings, foreign_key: "attended_event_id"
  has_many :attendees, through: :event_attendings, source: :attendee
  # through is plural since it is a table name
  # source is singular
end