class NewsCategory < ApplicationRecord
  has_many :news_sub_categories
end
