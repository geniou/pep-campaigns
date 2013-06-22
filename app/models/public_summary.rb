class PublicSummary < Summary

  attr_accessor :application

  def initialize(key)
    @application = Application.find_by_summary_key!(key)
  end

  private

  def _application_questions
    super.where(hide_on_summary: false)
  end

  def _applicant_questions
    super.where(hide_on_summary: false)
  end

  def _reference_questions
    super.where(hide_on_summary: false)
  end

  def _application_reference_answers(question)
    super.where(hide_on_summary: false)
  end

  def _answers(question)
    super.where(hide_on_summary: false)
  end
end
