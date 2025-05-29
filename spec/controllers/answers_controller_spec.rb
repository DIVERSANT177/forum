require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it "assigns a new answer for question" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new answer" do
        expect {
          post :create, params: { question_id: question, answer: attributes_for(:answer) }
      }.to change(Answer, :count).by(1)
      end

      it "redirects to question path" do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question)
      end
    end

    context "with invalid attributes" do
      it "does not creates a new answer" do
        expect {
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
      }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context "with valid attributes" do
      it "assigns updating answer" do
        patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question.id }
        expect(assigns(:answer)).to eq answer
      end

      it "changes answer attributes" do
        patch :update, params: { id: answer, answer: { title: "new title", body: "new body" }, question_id: question.id }
        answer.reload
        expect(answer.title).to eq 'new title'
        expect(answer.body).to eq 'new body'
      end

      it "redirects to the question" do
        patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question.id }
        expect(response).to redirect_to question_path(question)
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: answer, answer: { title: "new title", body: nil }, question_id: question.id } }
      it "does not changes answer attributes" do
        answer.reload
        expect(answer.title).to eq 'MyString'
        expect(answer.body).to eq 'MyText'
      end

      it "re-renders edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { answer }
    it "deletes answer" do
      expect { delete :destroy, params: { id: answer, question_id: question } }.to change(Answer, :count).by(-1)
    end

    it "redirects to the question" do
      delete :destroy, params: { id: answer, question_id: question }
      expect(response).to redirect_to question_path(question)
    end
  end
end
