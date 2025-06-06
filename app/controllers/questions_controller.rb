class QuestionsController < ApplicationController
  before_action :load_question, only: [ :show, :edit, :update, :destroy  ]
  before_action :authenticate_user!, except: [ :index, :show ]

  load_and_authorize_resource

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      ActionCable.server.broadcast(
      "questions",
      {
        question_html: render_to_string(partial: "questions/question", locals: { question: @question })
      })
      redirect_to @question, notice: "Your question successfully created"
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  # def export_all
  #   TestWorker.set(queue: :default).perform_async(current_user.id)
  #   redirect_to questions_path, notice: "Фоновая задача запущена. Он скачается автоматически."
  # end

  def test
    TestWorker.perform_async(current_user.id)
    redirect_to questions_path, notice: "Фоновая задача запущена"
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [ :id, :file ]).merge(user_id: current_user.id)
  end
end
