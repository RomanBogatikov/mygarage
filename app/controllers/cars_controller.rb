class CarsController < ApplicationController
  before_action :require_login
  before_action :set_car, only: [:show, :edit, :update, :destroy]


  # GET /cars
  # GET /cars.json
  def index
    unless current_user
      redirect_to root_url
      return
    end

    puts "/cars index = #{params}"
    # @cars = Car.all
    # @cars = Car.where("user_id = ?", params[:user_id])
    if params[:user_id]
      @cars = User.find(params[:user_id]).cars
    else
      @cars = Car.all
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    puts "show route"
    @car = Car.find(params[:id])
    @services = Car.find(params[:id]).services
    puts "services= #{@services}"
  end

  # GET /cars/new
  def new
    # @car = Car.new
    @car = current_user.cars.build
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    car_params[:user_id] = params[:user_id]
    puts "car_params = #{car_params}"
    @car = current_user.cars.build(car_params)
    # @car = Car.new(params[:car].permit(:user_id, :year, :make, :model))
    puts "@car = #{@car}"
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    # check how to implement protected routes (with this condition not logged in user can't delete a car)
    if current_user
      @car.destroy
      respond_to do |format|
        format.html { redirect_to user_cars_url(user_id: current_user.id), notice: 'Car was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def require_login
      unless current_user
        flash[:error] = "You must be logged in to access this section"
        redirect_to root_url # halts request cycle
      end
    end

    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:year, :make, :model).merge(user_id: current_user.id)
    end
end
