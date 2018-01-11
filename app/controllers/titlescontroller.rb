class TitlesController < ApplicationController

  get '/titles' do
    @titles = Title.all
    erb :'/titles/index'
  end

end
