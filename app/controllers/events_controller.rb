class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    
    respond_to do |format|
      if @event.update(event_params)
        stripe_auto_pay
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end        
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :category, :amount, :event_completed_on, :user_id)
    end

    def stripe_auto_pay
        @event.pledges.each do |pledge|
  
          product = Stripe::Product.create({
            name: pledge.user.email + 'donation' + pledge.id.to_s
          })
  
          price = Stripe::Price.create({
            product: product,
            unit_amount: ((@event.amount * pledge.amount)*100).to_i,
            currency: 'usd'
          })
  
          Stripe::InvoiceItem.create({
            customer: pledge.user.stripe_customer_id,
            price: price
          })
  
          invoice = Stripe::Invoice.create({
            customer: pledge.user.stripe_customer_id,
            collection_method: 'charge_automatically',
            auto_advance: true
          })
  
        end

    end
end
