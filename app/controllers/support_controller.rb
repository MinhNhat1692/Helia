class SupportController < ApplicationController
  before_action :logged_in_user, only: [:listticket, :ticketinfo, :addticket, :deleteticket, :closeticket, :addcomment, :deletecomment]
  
  def listticket
    if current_user.admin != 1
      if params.has_key?(:status)
        @data = []
			  @data[0] = SupportTicket.where(user_id: current_user.id, status: params[:status])
			  render json: @data
      else
        @data = []
			  @data[0] = SupportTicket.where(user_id: current_user.id).where.not(status: 3)
			  render json: @data
			end
    else
      if params.has_key?(:status)
        @data = []
			  @data[0] = SupportTicket.where(status: params[:status])
			  render json: @data
      else
        @data = []
			  @data[0] = SupportTicket.where.not(status: 3)
			  render json: @data
			end
    end
  end

  def ticketinfo
    if current_user.admin != 1
      if params.has_key?(:id)
				@ticket = SupportTicket.find_by(id: params[:id], user_id: current_user.id)
				if !@ticket.nil?
			    @comment = SupportComment.where(ticket_id: params[:id])
			    render json: @comment
			  end
			end
    else
      if params.has_key?(:id)
			  @comment = SupportComment.where(ticket_id: params[:id])
			  render json: @comment
			end
    end
  end

  def addticket
    if current_user.admin != 1
      if params.has_key?(:attachment)
        @ticket = SupportTicket.new(user_id: current_user.id, title: params[:title], infomation: params[:infomation], attachment: params[:attachment], status: 1)
			  if @ticket.save
				  render json: @ticket
			  else
				  render json: @ticket.errors, status: :unprocessable_entity
			  end
			else
        @ticket = SupportTicket.new(user_id: current_user.id, title: params[:title], infomation: params[:infomation], status: 1)
			  if @ticket.save
				  render json: @ticket
			  else
				  render json: @ticket.errors, status: :unprocessable_entity
			  end
			end
    end
  end

  def deleteticket
    if params.has_key?(:id)
		  @ticket = SupportTicket.find(params[:id])
		  if @ticket.user_id == current_user.id
		    @ticket.destroy
			  head :no_content
			end
		end
  end

  def closeticket
    if params.has_key?(:id)
		  @ticket = SupportTicket.find(params[:id])
		  if @ticket.user_id == current_user.id
		    if @ticket.update(status: 3)
				  render json: @ticket
				else
				  render json: @ticket.errors, status: :unprocessable_entity
				end
			end
		end
  end

  def addcomment
    if current_user.admin != 1
      if params.has_key?(:id)
		    @ticket = SupportTicket.find(params[:id])
		    if @ticket.user_id == current_user.id and @ticket.status != 3
		      if params.has_key?(:attachment)
            @comment = SupportComment.new(user_id: current_user.id, ticket_id: params[:id], comment: params[:comment], attachment: params[:attachment])
			      if @comment.save
              @ticket.update(status: 1)
				      render json: @comment
			      else
				      render json: @comment.errors, status: :unprocessable_entity
			      end
			    else
            @comment = SupportComment.new(user_id: current_user.id, ticket_id: params[:id], comment: params[:comment])
			      if @comment.save
              @ticket.update(status: 1)
				      render json: @comment
			      else
				      render json: @comment.errors, status: :unprocessable_entity
			      end
			    end
			  else
				  head :no_content	
			  end
		  end
    else
      if params.has_key?(:id)
		    @ticket = SupportTicket.find(params[:id])
		    if @ticket.status != 3
		      if params.has_key?(:attachment)
            @comment = SupportComment.new(user_id: current_user.id, ticket_id: params[:id], comment: params[:comment], attachment: params[:attachment])
			      if @comment.save
              @ticket.update(status: 2)
				      render json: @comment
			      else
				      render json: @comment.errors, status: :unprocessable_entity
			      end
			    else
            @comment = SupportComment.new(user_id: current_user.id, ticket_id: params[:id], comment: params[:comment])
			      if @comment.save
              @ticket.update(status: 2)
				      render json: @comment
			      else
				      render json: @comment.errors, status: :unprocessable_entity
			      end
			    end
			  else
					head :no_content
			  end
		  end
    end
  end

  def deletecomment
    if params.has_key?(:id)
		  @comment = SupportComment.find(params[:id])
		  if @comment.user_id == current_user.id
		    @comment.destroy
			  head :no_content
			end
		end
  end
  
  private
  	# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
end
