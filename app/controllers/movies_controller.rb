# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    #@movies = Movie.all
    params[:sort_by] == nil ? @hilite = false : @hilite = true
    @movies = Movie.find(:all, :order => params[:sort_by])
    params[:sort_by] == nil ? @id = nil : params[:sort_by] == "title" ? @id = :title_header : @id = :release_date_header
    @all_ratings = Movie.get_ratings 
    @show_by_rating = params[:ratings]
    #@id == nil ? @checked_boxes = @all_ratings : @checked_boxes = @show_by_ratings.keys
    #@checked_boxes = @all_ratings 
    if @show_by_rating != nil
    	@movies = Movie.find_all_by_rating(@show_by_rating.keys)
        @checked_boxes = @show_by_rating.keys
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  


end
