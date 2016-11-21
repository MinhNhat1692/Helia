class NewsController < ApplicationController

  def index
    @cat = NewsCategory.all
    @sub = NewsSubCategory.all
    if params[:cat_id]
      @con = News.where(news_sub_category_id: params[:cat_id])
    else
      @con = News.all
    end
  end

  def show
    @cat = NewsCategory.all
    @sub = NewsSubCategory.all
    id = params[:link].split("-").last
    @con = []
    news = News.find id
    @con << news
    main_cat = news.news_sub_category.news_category
    ids = main_cat.news_sub_categories.pluck(:id).drop(news.id)
    @related = News.where(news_sub_category: ids).sample(5)
  end
end
