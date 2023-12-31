class BoardsController < ApplicationController
    # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    # boardsにいる状態から、onlyで指定したアクションを実行しようとしたらautheticate_userによってログインページに遷移させられる
    # =onlyで指定したアクションはログインしていないとできない
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  def index
    # Boardテーブルからすべてを取得
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = current_user.boards.build
  end

  def create
    # userとboardは1対多なので、boards.build
    @board = current_user.boards.build(board_params)
    if @board.save
      # 保存できたらidexに　board_path(@board)はいらない？
      redirect_to root_path, notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました' # rubocop:disable Layout/IndentationWidth
      render :new
    end
  end

  def edit
    @board = Board.find(params[:id])
    if current_user.id == @board.user_id
      # current_userを使うことで、他人のeditをできなくする
      @board = current_user.boards.find(params[:id])
    else
      redirect_to root_path, notice:'編集できんよ'
    end
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      # 保存できたらboard_path(@board)ではなく、indexに
      redirect_to root_path, notice: '更新できた'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end


  private

  def board_params
    params.require(:board).permit(:title, :content)
  end

end
