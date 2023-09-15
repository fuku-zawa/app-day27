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
    @board = current_user.boards
  end

  def new
    @board = current_user.boards.build
  end

  def create
    # userとboardは1対多なので、boards.build
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path(@board), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました' # rubocop:disable Layout/IndentationWidth
      render :new
    end

  end



  private

  def board_params
    params.require(:board).permit(:title, :content)
  end

end
