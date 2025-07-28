class Author < ApplicationRecord
  has_many :books

  validates :first_name, presence: true

  accepts_nested_attributes_for :books

  def name
    "#{first_name} #{last_name}".strip
  end
end
