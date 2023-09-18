class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    # userとtaskは1対多なので、tasks.build
    @task = current_user.tasks.build(task_params)
    if @task.save
      # 保存できたらidexに　task_path(@task)はいらない？
      redirect_to tasks_path, notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました' # rubocop:disable Layout/IndentationWidth
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    if current_user.id == @task.user_id
      # current_userを使うことで、他人のeditをできなくする
      @task = current_user.tasks.find(params[:id])
    else
      redirect_to root_path, notice: '編集できんよ'
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      # 保存できたらtask_path(@task)ではなく、indexに
      redirect_to tasks_path, notice: '更新できた'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to tasks_path, notice: '削除に成功しました'
  end


  private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch, :deadline)
  end

end