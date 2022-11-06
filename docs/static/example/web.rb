require 'sinatra'
require 'sinatra/json'
require 'drb/drb'
require 'json'

require './common'

DRb.start_service

todos = DRbObject.new_with_uri DRUBY_URI

puts "Connected to business on URI #{DRUBY_URI}"

get '/api/todos' do
  for todo in todos.todos
    p todo
  end

  json todos.todos
end

post '/api/todos' do
  input = JSON.parse request.body.read

  json todos.add_todo(input['title'], input['body'])
end

delete '/api/todos/:id' do
  json todos.delete_todo(params['id'])
end

get '/todos' do
  @todos = todos.todos

  erb :todos
end

post '/todos' do
  todos.add_todo(params['title'], params['body'])

  redirect back
end

post '/todos/:id' do
  todos.delete_todo(params['id'])

  redirect back
end

get '/' do
  redirect '/todos'
end
