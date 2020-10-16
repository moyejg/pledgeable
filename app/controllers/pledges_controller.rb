class PledgesController < ApplicationController
  before_action :set_pledge, only: [:show, :edit, :update, :destroy]

  # GET /pledges
  # GET /pledges.json
  def index
    @pledges = Pledge.all
  end

  # GET /pledges/1
  # GET /pledges/1.json
  def show
  end

  # GET /pledges/new
  def new
    @pledge = Pledge.new
    @event = Event.find(params[:id])
  end

  # GET /pledges/1/edit
  def edit
  end

  # POST /pledges
  # POST /pledges.json
  def create
    @pledge = Pledge.new(pledge_params)   
    @pledge.user_id = current_user.id
    @event = Event.find_by(params[:id])

    respond_to do |format|
      if @pledge.save
        format.html { redirect_to @event, notice: 'Pledge was successfully created.' }
        format.json { render :show, status: :created, location: @pledge }
      else
        format.html { render :new }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pledges/1
  # PATCH/PUT /pledges/1.json
  def update
    respond_to do |format|
      if @pledge.update(pledge_params)
        format.html { redirect_to @pledge, notice: 'Pledge was successfully updated.' }
        format.json { render :show, status: :ok, location: @pledge }
      else
        format.html { render :edit }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pledges/1
  # DELETE /pledges/1.json
  def destroy
    @pledge.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Pledge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pledge
      @pledge = Pledge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pledge_params
      params.require(:pledge).permit(:amount, :max_amount, :user_id, :event_id)
    end
end
