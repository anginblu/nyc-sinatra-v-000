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


  post '/figures/:slug' do
    erb :'/figures/show'
  end
end
