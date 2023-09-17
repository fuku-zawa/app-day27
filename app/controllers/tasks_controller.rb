class TasksController < ApplicationController

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
    # userとboardは1対多なので、boards.build
    @task = current_user.tasks.build(task_params)
    if @task.save
      # 保存できたらidexに　board_path(@board)はいらない？
      redirect_to task_path, notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました' # rubocop:disable Layout/IndentationWidth
      render :new
    end
  end

end