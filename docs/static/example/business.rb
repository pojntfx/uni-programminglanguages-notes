require 'drb/drb'
require 'securerandom'

require './common'

class QuestionsServer
  attr_reader :questions

  def initialize
    @questions = []
  end

  def add_question(title, body)
    question = { id: SecureRandom.uuid, title: title, body: body }

    @questions << question

    question[:id]
  end

  def delete_question(id)
    @questions.delete_if do |question|
      question[:id] == id
    end

    id
  end
end

DRb.start_service DRUBY_URI, QuestionsServer.new

puts "Business listening on URI #{DRUBY_URI}"

DRb.thread.join
