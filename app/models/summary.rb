class Summary

  attr_accessor :application

  def initialize(application)
    @application = application
  end

  def references
    {
      questions: questions,
      count: @application.references.count
    }
  end

  private

  def questions
    @application.reference_questions.map do |question|
      [
        question.text,
        question.summary_type,
        question.summary(application_answers(question)),
        question.summary(question.answers)
      ]
    end
  end

  def application_answers(question)
    Answer
      .includes(:reference)
      .where('"references"."application_id" = ? and "answers"."question_id" = ?',
             @application.id, question.id)
  end
end
