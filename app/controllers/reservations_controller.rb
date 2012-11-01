class ReservationsController < ApplicationController
  # GET /reservations
  # GET /reservations.json
  def index
    redirect_to home_path
  rescue 
    redirect_to home_path
  #  @search = Reservation.search(params[:q])
    #@reservations = Reservation.paginate page: params[:page], order: 'startdate', per_page: 10
  #  @reservations = @search.result.paginate page: params[:page], order: 'startdate', per_page: 10
  #  @search.build_condition
    
   # respond_to do |format|
   #   format.html # index.html.erb
   #   format.json { render json: @reservations }
   # end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = Reservation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/doesnotexist.html"
    #render :json => "record not Record Not Found"
  rescue

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format|
      if @reservation.save
        ReservationNotifier.newreservation(@reservation).deliver
        format.html { redirect_to @reservation, notice: 'Your reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        ReservationNotifier.newreservation(@reservation).deliver
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end
end
