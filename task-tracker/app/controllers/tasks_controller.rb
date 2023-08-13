class TasksController < ApplicationController
  # before_action :authenticate_account!
  before_action :fetch_task, only: %i[show complete_task]

  def index
    @tasks = Task.all
  end

  def show
    return unless @task

    format.json { render json: @task, status: :ok }
  end

  def create
    @task = build_task(task_params)

    if @task.save
      Events::ProduceEvent.new(
        topics: ['tasks', 'tasks-stream'], # CUD + BE events topic
        payload: Events::BuildPayload(:task_created, @task)
      )

      format.html { redirect_to root_path, notice: 'Task was successfully updated.' }
      format.json { render :index, status: :ok, location: @task }
    else
      format.html { render :edit }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  def complete_task
    @task.status = 'Completed'

    if @task.save
      Events::ProduceEvent.new(
        topics: ['tasks'], # BE events topic
        payload: Events::BuildPayload(:task_completed, @task)
      )
      format.html { redirect_to root_path, notice: 'Task was successfully updated.' }
      format.json { render :index, status: :ok, location: @task }
    else
      format.html { render :edit }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  def reassign_all
    Task.all.each { |task| reassign(task) }
  end

  private

  def assign_random_worker(task)
    # TODO: add logic for assigning random user
    task.assignee = Account.last
    task
  end

  def build_task(params)
    task = Task.new(params)

    task.assignee = assign_random_worker(task)
    task.cost = rand(-20..-10)
    task.reward = rand(20..40)

    task
  end

  def fetch_task
    @task = Task.find(params[:id])
  end

  def reassign(task)
    task = assign_random_worker(task)
    return unless task.save

    Events::ProduceEvent.new(
      topics: ['tasks'], # BE events topic
      payload: Events::BuildPayload(:task_reassigned, @task)
    )
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
