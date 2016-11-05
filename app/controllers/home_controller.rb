class HomeController < ApplicationController
  def index
    if logged_in?
			flash[:success] = "Chào mừng " + current_user.name
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
  
  def changelog
		if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		  @lcl = CLog.all().group(:d_a).order(d_a: :desc)
		  @records = CLog.all().order(d_a: :desc)
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
		  @lcl = CLog.all().group(:d_a).order(d_a: :desc)
		  @records = CLog.all().order(d_a: :desc)
    end
	end
  
  def changelogfind
		if params.has_key?(:d_a)
			@records = CLog.where("d_a = ?" , params[:d_a]).order(updated_at: :desc)
			render json:@records
		end
	end
  
  def news
		if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		  @headers = NewsHeader.where("cat = ?", 1).order(updated_at: :desc).limit(100)
		  @recommend = NewsHeader.where("cat = ? and recomend = ?", 1, true).order(updated_at: :desc).limit(5)
		  @mostview = NewsHeader.where("cat = ?", 1).order(view: :desc).limit(5)
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
		  @headers = NewsHeader.where("cat = ?", 1).order(updated_at: :desc).limit(100)
		  @recommend = NewsHeader.where("cat = ? and recomend = ?", 1, true).order(updated_at: :desc).limit(5)
		  @mostview = NewsHeader.where("cat = ?", 1).order(view: :desc).limit(5)
    end
	end
  
  def newsfind
		if params.has_key?(:cat)
			@data = []
			@data[0] = NewsHeader.where("cat = ?", params[:cat]).order(updated_at: :desc).limit(100)
		  @data[1] = NewsHeader.where("cat = ? and recomend = ?", params[:cat], true).order(updated_at: :desc).limit(5)
		  @data[2] = NewsHeader.where("cat = ?", params[:cat]).order(view: :desc).limit(5)
		  render json: @data
		elsif params.has_key?(:news_id)
			@data = NewsContent.find_by(news_header_id: params[:news_id])
			render json:@data
		end
	end
  
  def features
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
  
  def pricing
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
  
  def enterprise
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
  
  def demo
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
  
  def demoadd
		@room = DemoRequest.new(fname: params[:fname], lname: params[:lname], email: params[:email], sname: params[:sname], pnumber: params[:pnumber])
  	if @room.save
	    render json: @room
		else
		  render json: @room.errors, status: :unprocessable_entity
		end
  end
  
  def documentation
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
  
  def documentation_guide
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		  @cat = DocCat.all()
		  @sub = DocSub.all()
		  if params.has_key?(:sub_id)
				@con = DocCon.where("doc_subs_id = ?" , params[:sub_id])
			else
				@con = DocCon.where("doc_subs_id = 1")
			end
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
		  @cat = DocCat.all()
		  @sub = DocSub.all()
		  if params.has_key?(:sub_id)
				@con = DocCon.where("doc_subs_id = ?" , params[:sub_id])
			else
				@con = DocCon.where("doc_subs_id = 1")
			end
    end
  end
  
  def documentation_guide_request
		if params.has_key?(:sub_id)
			@con = DocCon.where("doc_subs_id = ?" , params[:sub_id])
			render json: @con
		else
		  @con = DocCon.where("doc_subs_id = 1")
		  render json: @con
		end
	end
end
