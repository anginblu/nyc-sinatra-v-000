class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures/new' do

    @figure = Figure.create(name: params["figure_name"])

    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @figure.figure_titles.create(title: @title)
      end
    end
    if !params["new_title"].empty?
      @title = Title.create(name: params["new_title"])
      @figure.figure_titles.create(title: @title)
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @figure.landmarks << @landmark
      end
    end
    if !params["new_landmark"].empty?
      @landmark = Landmark.create(name: params["new_landmark"])
      @figure.landmarks << @landmark
    end
    @figure.save

    redirect to "/figures/#{@figure.slug}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id/edit' do
    @figure = Figure.find_by_slug(params[:slug])

    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @figure.figure_titles.create(title: @title)
      end
    end
    if !params["new_title"].empty?
      # @title = Title.create(name: params["new_title"])
      @figure.figure_titles.create(title: params["new_title"])
    end
    @figure.save

    if params["new_landmark"].empty?
      @figure.landmarks = []
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @figure.landmarks << @landmark
        @figure.save
      end
    else
      @landmark = Landmark.create(name: params["new_landmark"])
      @figure.landmarks << @landmark
      @figure.save
    end

    redirect to "/figures/#{@figure.id}"
  end
end
