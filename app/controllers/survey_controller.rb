require 'hashed_id'

class SurveyController < ApplicationController

protected

  def read_answers_from_params(params, klass)
    params.select { |k,v| k.to_s.start_with?("answer_") }.collect do |key, text|
      question_id = key.split(/_/).last
      next unless question_id
      question = Question.find_by_id(question_id)
      next unless question
      klass.new(:question => question, :text => text)
    end
  end

end
