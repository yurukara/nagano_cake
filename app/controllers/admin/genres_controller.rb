class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to request.referer
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(update_params)
      redirect_to admin_genres_path
    else
      render 'edit'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def update_params
    params.require(:genre).permit(:name)
  end

end
