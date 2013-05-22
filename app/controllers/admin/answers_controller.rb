class Admin::AnswersController < Admin::BaseController

  def hide_on_summary
    @answer = Answer.find(params[:answer_id])
    @answer.update_attribute(:hide_on_summary, true)
  end

  def show_on_summary
    @answer = Answer.find(params[:answer_id])
    @answer.update_attribute(:hide_on_summary, false)
  end
end
