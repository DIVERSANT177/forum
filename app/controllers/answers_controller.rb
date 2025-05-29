class AnswersController < ApplicationController
  before_action :load_question, only: [ :new, :create, :update, :destroy ]
  before_action :load_answer, only: [ :destroy, :update ]
  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question)
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:title, :body)
  end
end
