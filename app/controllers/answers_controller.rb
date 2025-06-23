class AnswersController < ApplicationController
  before_action :load_question
  before_action :load_answer, except: [ :create ]
  before_action :authenticate_user!

  load_and_authorize_resource

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      ActionCable.server.broadcast(
      "answers",
      {
        user_id: current_user.id,
        answer_html: render_to_string(partial: "answers/answer", locals: { answer: @answer })
      })
      respond_to do |format|
        format.js
        # format.html { redirect_to question_path(@question) }
      end
    end
  end

  def destroy
    if @answer.destroy
      respond_to do |format|
        format.js
      end
    else
        puts "Failed to destroy answer: #{@answer.errors.full_messages}"
        head :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def rate_up
    @like = Like.new(answer_id: @answer.id, user_id: current_user.id)
    if @like.save
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:title, :body, attachments_attributes: [ :id, :file ]).merge(user_id: current_user.id)
  end
end
