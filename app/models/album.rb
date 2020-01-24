class Album < ApplicationRecord
  scope :rock, -> { where(genre: "Rock") }
  has_one_attached :album_cover_photo
  # Alternate way of writing a class method with scope
  # def self.rock
  #   where(genre: "Rock")
  # end

  has_and_belongs_to_many(:artists)

  has_many :songs, dependent: :destroy

  validates :name, presence: true

  validates_length_of :name, maximum: 100

  before_save(:titleize_album)

  private
  def titleize_album
    self.name = self.name.titleize
  end

end
