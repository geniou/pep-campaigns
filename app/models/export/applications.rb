class Export::Applications < Export::Base

  attr_accessor :applications

  def initialize(applications)
    @applications = applications
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
    applications.each do |application|
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
    end
    export
  end

  private

  def referee_questions
    applications.first.referee_questions
  end

  def reference_questions
    applications.first.reference_questions
  end
end
