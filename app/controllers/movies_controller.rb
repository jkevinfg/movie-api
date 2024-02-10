class MoviesController < ActionController::API
  def index
    @movies = Movie.all
    render json: @movies
  end

  def create
    @movie = Movie.create movie_params

    if @movie.valid?
      render json: @movie, status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find params[:id]
    render status: :no_content
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :quote)
  end
end
