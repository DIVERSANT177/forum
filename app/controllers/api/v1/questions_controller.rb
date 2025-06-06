class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    @questions = Question.all
    respond_with @questions
  end

  # def show
  #   respond_with current_resource_owner
  # end
end
