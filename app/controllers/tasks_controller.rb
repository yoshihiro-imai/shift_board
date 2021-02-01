class TasksController < ApplicationController
 # before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @protest = Project.joins(:tasks).select('projects.*, tasks.*')
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @projects = Project.joins(:tasks).select('projects.*, tasks.*')
    @task = @projects.where(tasks:{start_time:params[:id]})
    @timeline = @projects.where(tasks:{start_time:params[:id]}) .map do |project|
    [project.nickname, intime(project),outtime(project)]
    end
  end


  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
 
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:start_time, :intime, :outtime, :project_id)
    end

    def intime(project)
      "#{project.start_time.year}-#{project.start_time.month}-#{project.start_time.day} #{project.intime.strftime('%H:%M')}"
    end

    def outtime(project)
      "#{project.start_time.year}-#{project.start_time.month}-#{project.start_time.day} #{project.outtime.strftime('%H:%M')}"
    end
end
