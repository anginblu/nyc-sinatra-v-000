class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/:slug' do
    @figure = Figure.find_by_slug(params[:slug])
    erb :'/figures/show'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    binding.pry
    @figure = Figure.create(params[:figure][:name])
    if params[:title][:name].empty?
      @figure.figure_titles.create(params[:figure][:title_ids])
    else
      @figure.figure_titles.create(params[:title][:name])
    end
    erb :'/figures/show'
  end
end
