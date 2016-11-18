class News < ApplicationRecord
  belongs_to :news_sub_category
  validates :title, presence: true
  validates :content, presence: true

  def generate_link
    link = self.title.downcase.gsub(" ", "-")
    return "#{link}-#{self.id}"
  end
end
