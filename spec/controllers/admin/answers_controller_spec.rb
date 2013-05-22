require 'spec_helper'

describe Admin::AnswersController do

  before { controller.stub(:authenticate_admin!) }

  describe 'hide_on_summary' do
    let(:answer) { double('answer') }
    before do
      Answer.should_receive(:find)
        .with("123").and_return(answer)
      answer.should_receive(:update_attribute)
        .with(:hide_on_summary, true)
    end

    it 'marks answer' do
      put :hide_on_summary, answer_id: 123
    end
  end

  describe 'show_on_summary' do
    let(:answer) { double('answer') }
    before do
      Answer.should_receive(:find)
        .with("123").and_return(answer)
      answer.should_receive(:update_attribute)
        .with(:hide_on_summary, false)
    end

    it 'marks answer' do
      put :show_on_summary, answer_id: 123
    end
  end
end
