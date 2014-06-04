require 'wunderground'
require 'mail'
class PlansController < ApplicationController

  before_filter :authenticate_user!

  # GET /plans
  # GET /plans.json
  def index
    @plans = current_user.plans

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])

    w = Wunderground.new('bef26a2b0f485846')
    @forecast = w.forecast_for(@plan.city.gsub(' ', '_'))

    if params['email'] != nil
      emailAd = params['email']
      subjectP = 'Itinerario del viaje ' + @plan.name.to_s
      options = {:address => "smtp.gmail.com",
                 :port => 587,
                 :user_name => 'noreply.supertravel@gmail.com',
                 :password => 'Hola1234',
                 :authentication => 'plain',
                 :enable_starttls_auto => true}
      bodyP = current_user.email + " te envia su itinerario para el viaje " + @plan.name.to_s + "\n"
      @plan.events.each do |event|
        bodyP += (Eventful.get_event(event)['title'] + "\n")
      end

      Mail.deliver do
        to emailAd
        from 'noreply.supertravel@gmail.com'
        subject subjectP
        body bodyP
        delivery_method :smtp, options
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
      format.pdf {
        html = render_to_string(:layout => 'pdf.html.erb', :action => 'show.html.erb', :formats => [:html], :handler => [:erb])
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root.to_s}/app/assets/stylesheets/application.css"
        send_data(kit.to_pdf, :filename => "#{@plan.name.gsub(' ', '')}.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    params[:plan]["user"] = current_user
    @plan = Plan.new(params[:plan])

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render json: @plan, status: :created, location: @plan }
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end

  def add_event
    @plan = Plan.find(params[:id])
    event = Event.create(:api_id => params[:event_id])
    @plan.add_event(event.api_id)

    respond_to do |format|
      format.html { redirect_to '/plans/' + params[:id] }
      format.json { head :no_content }
    end
  end

  def remove_event
    @plan = Plan.find(params[:id])
    @plan.remove_event(params[:event_id])

    respond_to do |format|
      format.html { redirect_to '/plans/' + params[:id] }
      format.json { head :no_content }
    end
  end
end