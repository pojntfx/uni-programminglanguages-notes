require 'drb/drb'
require 'securerandom'

require './common'

class TodosServer
  attr_reader :todos

  def initialize
    @todos = []
  end

  def add_todo(title, body)
    todo = { id: SecureRandom.uuid, title: title, body: body }

    @todos << todo

    todo[:id]
  end

  def delete_todo(id)
    @todos.delete_if do |todo|
      todo[:id] == id
    end

    id
  end
end

DRb.start_service DRUBY_URI, TodosServer.new

puts "Business listening on URI #{DRUBY_URI}"

DRb.thread.join
