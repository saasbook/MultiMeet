class TimesController < ApplicationController
  before_action :set_time, only: [:show, :edit, :update, :destroy]
  
  # GET /times/new
  def new
    @time = ProjectTime.new
    @project_id = params[:project_id]
    @duration = Project.find(@project_id).duration
    @hour = @duration/60.ceil
    @minute = @duration - (@hour*60)
  end
  
  # GET /times
  # GET /times.json
  def index
    @project_id = params[:project_id]
    @duration = Project.find(@project_id).duration
    @times = ProjectTime.where(project_id: @project_id).order(:date_time)
  end

  # POST /times/new
  # POST /times.json
  def create
    @project_id = params[:project_id]
    
    if params[:project_time][:date_time].nil? or params[:project_time][:date_time].empty?
      flash[:message] = "No date chosen."
      redirect_to new_project_time_path and return
    end
    
    @new_duration = params[:timeslot_hour].to_i * 60 + params[:timeslot_minute].to_i
    @project = Project.find(@project_id)
    @project.update(duration: @new_duration)
  
    #Loop Through params[:times]
    params[:times].keys().each do |date|
      #Add dates to database
      if ProjectTime.where(project_id: @project_id, date_time: DateTime.parse(date), is_date: true).blank?
        @time = ProjectTime.new(project_id: @project_id, date_time: date, is_date: true)
        @time.save
      end
      #Add times of the date into database
      params[:times][date].each_with_index do |time, index|
        #Even indexes are start times, odd indexes are end times
        if (index % 2 == 0)
          time = time + ":00"
          #puts "Date: " + date + "| Time: " + time
          if ProjectTime.where(project_id: @project_id, date_time: DateTime.parse(date + " " + time), is_date:false).blank?
            @time = ProjectTime.new(project_id: @project_id, date_time: DateTime.parse(date + " " + time), is_date:false)
            if @time.save
              (flash[:message] ||= "") << "#{DateTime.parse(date + " " + time).strftime("%A, %B %d %Y, %I:%M %p")}. "
            end
          else
            (flash[:error] ||= "") << "#{DateTime.parse(date + " " + time).strftime("%A, %B %d %Y, %I:%M %p")}. "
          end
        end
      end
    end
    
    redirect_to project_times_path
  end
  
  def destroy_all
    @project_id = params[:project_id]
    ProjectTime.where(project_id: @project_id).destroy_all
    Project.find(@project_id).update(duration: nil)
    redirect_to project_times_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time
      @time = ProjectTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_params
      params.require(:project_time).permit(:date_time, :is_date)
    end
end

# PATCH/PUT /times/1
  # PATCH/PUT /times/1.json
  #def update
    #respond_to do |format|
      #if @time.update(time_params)
        #format.html { redirect_to @time, notice: 'Time was successfully updated.' }
        #format.json { render :show, status: :ok, location: @time }
      #else
        #format.html { render :edit }
        #format.json { render json: @time.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /times/1
  # DELETE /times/1.json
  #def destroy
    #@time.destroy
    #end
  #end