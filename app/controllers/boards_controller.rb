class BoardsController < ApplicationController
    # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    # boardsにいる状態から、onlyで指定したアクションを実行しようとしたらautheticate_userによってログインページに遷移させられる
    # =onlyで指定したアクションはログインしていないとできない
    before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

    def index
        # Boardテーブルからすべてを取得
        @boards = Board.all
    end

    def new
        @board = Board.new
    end



end
