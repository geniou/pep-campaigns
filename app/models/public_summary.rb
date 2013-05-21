class PublicSummary < Summary

  attr_accessor :application

  def initialize(key)
    @application = Application.find_by_summary_key!(key)
  end
end
