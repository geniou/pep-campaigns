class Summary

  attr_accessor :application

  def initialize(application)
    @application = application
  end

  def references
    {
      questions: question_list,
      count: @application.references.count
    }
  end

  protected

  def questions
    @application.reference_questions
  end

  private

  def question_list
    questions.map do |question|
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
