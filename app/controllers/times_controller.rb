class TimesController < ApplicationController
  before_action :set_time, only: [:show, :edit, :update, :destroy]

  # GET /times
  # GET /times.json
  def index
    @times = Time.all
  end

  # GET /times/1
  # GET /times/1.json
  def show
  end

  # GET /times/new
  def new
    @time = Time.new
  end

  # GET /times/1/edit
  def edit
  end

  # POST /times
  # POST /times.json
  def create
    @time = Time.new(time_params)

    respond_to do |format|
      if @time.save
        format.html { redirect_to @time, notice: 'Time was successfully created.' }
        format.json { render :show, status: :created, location: @time }
      else
        format.html { render :new }
        format.json { render json: @time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /times/1
  # PATCH/PUT /times/1.json
  def update
    respond_to do |format|
      if @time.update(time_params)
        format.html { redirect_to @time, notice: 'Time was successfully updated.' }
        format.json { render :show, status: :ok, location: @time }
      else
        format.html { render :edit }
        format.json { render json: @time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /times/1
  # DELETE /times/1.json
  def destroy
    @time.destroy
    respond_to do |format|
      format.html { redirect_to times_url, notice: 'Time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time
      @time = Time.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_params
      params.fetch(:time, {})
    end
end
