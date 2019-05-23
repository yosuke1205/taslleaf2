class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)

  end

  def show
    @task= Task.find(params[:id])
  end

  def new
  @task= Task.new
  end
  
  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
      
    end
  end

  def edit
    @task= Task.find(params[:id])
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  

  private
  def task_params 
    params.require(:task).permit(:name, :description)
  end


  def set_task
    @task = Task.find(params[:id])
  end
  end
