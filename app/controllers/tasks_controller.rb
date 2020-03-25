class TasksController < ApplicationController
  before_action :require_user_logged_in#, only: [:index, :show]
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,only: [:show, :edit, :update, :destroy]
  #include SessionsHelper
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
  
  #def edit
    #@task = Task.find(params[:id])
  #end
  
  def update
    
    #@task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    #@task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
=begin
  def set_task
    @task = Task.find(params[:id])
=end
  
 
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user #本人かどうか確認、違うとすれば一覧に遷移
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
