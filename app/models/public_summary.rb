class PublicSummary < Summary

  attr_accessor :application

  def initialize(key)
    @application = Application.find_by_summary_key!(key)
  end

  private

  def questions
    super.where(hide_on_summary: false)
  end

  def application_answers(question)
    super(question).where(hide_on_summary: false)
  end

  def answers(question)
    super(question).where(hide_on_summary: false)
  end
end
