class AnswersController < ApplicationController
  before_action :load_question
  before_action :load_answer, except: [ :create ]
  before_action :authenticate_user!
  # def new
  #   @answer = @question.answers.new
  # end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
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
        # format.html { redirect_to question_path(@question) }
      end
    else
        puts "Failed to destroy answer: #{@answer.errors.full_messages}"
        head :unprocessable_entity
    end
  end

  def update
    # debugger
    if @answer.update(answer_params)
      respond_to do |format|
        format.js
      end
      # redirect_to question_path(@question)
    else
      # render :edit
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
    params.require(:answer).permit(:title, :body).merge(user_id: current_user.id)
  end
end
