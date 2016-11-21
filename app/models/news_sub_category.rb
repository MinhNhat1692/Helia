class NewsSubCategory < ApplicationRecord
  belongs_to :news_category
  has_many :news
end
