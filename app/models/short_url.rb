class ShortUrl < ApplicationRecord
  validates :original_url, presence: true
  validates :short_code, uniqueness: true

  before_validation :generate_short_code, on: :create

  def generate_short_code
    self.short_code ||= loop do
      code = SecureRandom.alphanumeric(6)
      break code unless ShortUrl.exists?(short_code: code)
    end
  end
end
