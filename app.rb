require 'pry'
require 'sinatra'
require 'better_errors'
require 'sinatra/reloader'
require 'pg'
require "sinatra/activerecord"
require './models/artist'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

get '/' do
  redirect '/artists'
end

get '/artists' do
  @artists = Artist.all
  erb :index
end

get '/artists/new' do
  erb :new
end
get '/artists/:id' do
  @artists = Artist.find(params[:id])
  erb :show
end
get '/artists/:id/edit' do
  @artists = Artist.find(params[:id].to_i)
  erb :edit
end

post '/artists' do
  Artist.create params
  redirect '/artists'
end

put '/artists/:id' do
  n = Artist.find(params[:id].to_i)
  n.name = params[:name]
  n.save
  redirect '/artists'
end

delete '/artists/:id' do
  Artist.find(params[:id].to_i).destroy
  redirect '/artists'
end