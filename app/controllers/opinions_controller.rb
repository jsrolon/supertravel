class OpinionsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @event = @event.opinions.create(:text => params[:opinion][:text], :commenter => current_user.id)

    respond_to do |format|
      format.html { redirect_to '/events/' + params[:event_id].to_s }
      format.json { render json: @events }
    end
  end

  def destroy
    @opinion = Opinion.find(params[:opinion_id])
    @opinion.delete

    respond_to do |format|
      format.html { redirect_to '/events/' + params[:event_id].to_s }
      format.json { head :no_content }
    end
  end
end
