class Summary

  attr_accessor :application

  def initialize(application)
    @application = application
  end

  def applicant_questions
    applicant_question_list
  end

  def application_questions
    application_question_list
  end

  def number_of_references
    @application.references.count
  end

  def reference_questions
    reference_question_list
  end

  protected

  def _applicant_questions
    @application.campaign.applicant_questions
  end

  def _application_questions
    @application.campaign.application_questions
  end

  def _reference_questions
    @application.reference_questions
  end

  private

  def applicant_question_list
    _applicant_questions.map do |question|
      answer = question.answers.where(application_id: @application.id).first
      [
        question.text,
        answer ? question.formatted_value(answer.value) : nil,
      ]
    end
  end

  def application_question_list
    _application_questions.map do |question|
      answer = question.answers.where(application_id: @application.id).first
      [
        question.text,
        answer ? question.formatted_value(answer.value) : nil,
      ]
    end
  end

  def reference_question_list
    _reference_questions.map do |question|
      [
        question.text,
        question.summary_type,
        question.summary(_application_reference_answers(question)),
        question.summary(_answers(question))
      ]
    end
  end

  def _application_reference_answers(question)
    Answer
      .includes(:reference)
      .where('"references"."application_id" = ? and "answers"."question_id" = ?',
             @application.id, question.id).references(:reference)
  end

  def _answers(question)
    question.answers
  end
end
