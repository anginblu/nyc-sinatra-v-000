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

    if params["new_title"].empty?
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @figure.figure_titles.create(title: @title)
      end
    else
      @title = Title.create(name: params["new_title"])
      @figure.figure_titles.create(title: @title)
    end
    @figure.save

    if params["new_landmark"].empty?
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @figure.landmarks << @landmark
      end
    else
      @landmark = Landmark.create(name: params["new_landmark"])
      @figure.landmarks << @landmark
    end
    @figure.save

    redirect to "/figures/#{@figure.slug}"
  end

  get '/figures/:slug' do
    @figure = Figure.find_by_slug(params[:slug])
    erb :'/figures/show'
  end

end
