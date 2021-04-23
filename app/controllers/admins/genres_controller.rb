class Admins::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    if genre.save
      flash[:success] = "ジャンルを作成しました！"
      redirect_to admins_genres_path
    else
      flash[:danger] = "ジャンル作成に失敗しました。ジャンル名を入力してください"
      @genre = Genre.new
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      flash[:success] = "更新しました！"
      redirect_to admins_genres_path
    else
      flash[:danger] = "更新に失敗しました。ジャンル名を入力してください"
      @genre = Genre.find(params[:id])
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
