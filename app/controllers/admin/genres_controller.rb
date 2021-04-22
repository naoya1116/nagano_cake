class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  private

  def genre_params
   params.require(:genre).permit(:name,:created_at,:updated_at)
  end

end
