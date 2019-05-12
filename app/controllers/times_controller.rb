class TimesController < ApplicationController
  before_action :set_project_and_project_id, only: %i[index create destroy_all]

  # GET /times/new
  def new
    @time = ProjectTime.new
    @project_id = params[:project_id]
    @duration = Project.find(@project_id).duration
    unless @duration.nil?
      @hour = @duration / 60.ceil
      @minute = @duration - (@hour * 60)
    end
  end

  # GET /times
  # GET /times.json
  def index
    unless logged_in?
      require_user
      return
    end

    @duration = @project.duration
    @times = @project.project_times.order(:date_time)
  end

  def update_duration_from_params
    @project.update(duration: @duration)
  end

  def no_overlapping_times? datetime
    minDatetime = datetime.advance(hours: -@hour, minutes: -@minute)
    maxDatetime = datetime.advance(hours: +@hour, minutes: +@minute)

    minmaxquery = @project.project_times.where('date_time > ? AND date_time < ?', minDatetime, maxDatetime)

    # Check min time and max time
    unless minmaxquery.blank?
      (flash[:error] ||= '<br/>') << "#{DateTime.parse(date).strftime('%B %d %Y, %I:%M %p')} is an overlapping time.<br/>"
      return false
    end

    true
  end

  def date_time_exists?(datetime, is_date)
    query = @project.project_times.where(date_time: datetime, is_date: is_date)

    query.blank? ? false : true
  end

  def can_insert_times?(date, is_date)
    datetime = DateTime.parse(date)

    not date_time_exists?(datetime, is_date) && no_overlapping_times?(datetime)
  end

  # returns if a project time was created and saved
  def create_project_time_if_needed(date, time, is_date)
    date = date + ' ' + time unless is_date

    # let's do some validations
    if can_insert_times? date, is_date
      @time = @project.project_times.new(date_time: date, is_date: is_date)
      return @time.save
    end
    false
  end

  def add_date_to_db(date)
    create_project_time_if_needed date, nil, true
  end

  def add_time_to_db(date, time)
    time += ':00'
    if create_project_time_if_needed date, time, false
      (flash[:success] ||= 'Added times: <br/>') << "#{DateTime.parse(date + ' ' + time).strftime('%B %d %Y, %I:%M %p')} <br/>"
    end
  end

  def add_requested_times_to_db
    @form_times = params[:times]
    # Loop Through params[:times]
    @form_times.keys.each do |date|
      # Add dates to database
      add_date_to_db date
      # Add times of the date into database
      @form_times[date].each_with_index do |time, index|
        add_time_to_db date, time if index.even?
      end
    end
  end

  # POST /times/new
  # POST /times.json
  def create
    @hour = params[:timeslot_hour].to_i
    @minute = params[:timeslot_minute].to_i
    @duration = @hour * 60 + @minute

    if params[:project_time][:date_time].nil? || params[:project_time][:date_time].empty?
      flash[:message] = 'No date chosen.'
      redirect_to(new_project_time_path) && return
    elsif @duration == 0
      flash[:message] = 'Duration cannot be 0 minutes.'
      redirect_to(new_project_time_path) && return
    end

    update_duration_from_params

    add_requested_times_to_db

    redirect_to project_times_path
  end

  def destroy_all
    @project.project_times.destroy_all
    @project.update(duration: nil)
    redirect_to project_times_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_project_and_project_id
    @project_id = params[:project_id]
    @project = Project.find_by(id: @project_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def time_params
    params.require(:project_time)
  end
end

# PATCH/PUT /times/1
# PATCH/PUT /times/1.json
# def update
# respond_to do |format|
# if @time.update(time_params)
# format.html { redirect_to @time, notice: 'Time was successfully updated.' }
# format.json { render :show, status: :ok, location: @time }
# else
# format.html { render :edit }
# format.json { render json: @time.errors, status: :unprocessable_entity }
# end
# end
# end

# DELETE /times/1
# DELETE /times/1.json
# def destroy
# @time.destroy
# end
# end
