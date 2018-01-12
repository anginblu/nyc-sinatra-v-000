class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures/new' do

    @figure = Figure.create(name: params[:figure][:name])
# binding.pry
    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @figure.figure_titles.create(title: @title)
      end
    end
    if !params[:title][:name].empty?
      @title = Title.create(name: params[:title][:name])
      @figure.figure_titles.create(title: @title)
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @landmark.figure = @figure
      end
    end
    if !params["new_landmark"].empty?
      @landmark = Landmark.create(name: params["new_landmark"])
      @landmark.figure = @figure
    end
    @landmark.save
    # @figure.save
# binding.pry
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.figure_titles.clear
    @figure.landmarks.clear

    if !params[:figure][:name].empty?
      @figure.update(name: params[:figure][:name])
    end

    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @figure.figure_titles.create(title: @title)
      end
    end
    if !params[:title][:name].empty?
      @figure.figure_titles.create(title: params[:title][:name])
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @landmark.figure = @figure
      end
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name: params[:landmark][:name])
      @landmark.figure = @figure
    end
    @landmark.save
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
