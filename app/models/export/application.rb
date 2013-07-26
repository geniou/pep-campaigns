class Export::Application < Export::Base

  attr_accessor :application

  def initialize(application)
    @application = application
  end

  def data(export)
    head = ['First name', 'Last name', 'eMail']
    referee_questions.each do |answer|
      head << answer.text
    end
    reference_questions.each do |answer|
      head << answer.text
    end
    export << head
    application.references.each do |reference|
      answers = reference.answers.index_by(&:question_id)
      row = [
        reference.contact.first_name,
        reference.contact.last_name,
        reference.contact.email,
      ]
      referee_questions.each do |question|
        row << answers[question.id].to_s
      end
      reference_questions.each do |question|
        row << answers[question.id].to_s
      end
      export << row
    end
    export
  end

  private

  def referee_questions
    application.referee_questions.all
  end

  def reference_questions
    application.reference_questions.all
  end
end
