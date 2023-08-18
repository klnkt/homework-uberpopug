class TasksController < ApplicationController
  # before_action :authenticate_account!

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
    return unless @task

    format.json { render json: @task, status: :ok }
  end

  def create
    @task = build_task(task_params)

    if @task.save
      Events::ProduceEvent.new(
        topics: ['tasks-lifecycle', 'tasks-stream'], # CUD + BE events topic
        payload: Events::BuildPayload(:task_created, @task)
      )

      redirect_to tasks_path, notice: 'Task was created successfully.'
    else
      render :new
    end
  end

  def complete
    task = Task.find(params[:id])

    if task.update(status: 'Completed')
      Events::ProduceEvent.new(
        topics: ['tasks-lifecycle'], # BE events topic
        payload: Events::BuildPayload(:task_completed, @task)
      )
      redirect_to tasks_path, notice: 'Task was completed successfully.'
    else
      format.html { render :edit }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  def reassign_all
    Task.open.each { |task| reassign(task) }

    redirect_to tasks_path, notice: 'All tasks were reassigned successfully.'
  end

  private

  def assign_random_worker
    # TODO: add logic for assigning random user
    Account.last
  end

  def build_task(params)
    task = Task.new(params)

    task.account = assign_random_worker
    task.cost = rand(-20..-10)
    task.reward = rand(20..40)

    task
  end

  def reassign(task)
    task.account = assign_random_worker
    return unless task.save

    Events::ProduceEvent.new(
      topics: ['tasks-lifecycle'], # BE events topic
      payload: Events::BuildPayload(:task_reassigned, task)
    )
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
