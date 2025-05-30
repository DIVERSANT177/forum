require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new answer" do
        expect {
          post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
      }.to change(Answer, :count).by(1)
      end

      it "renders new answer " do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template("create")
      end
    end

    context "with invalid attributes" do
      it "does not creates a new answer" do
        expect {
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js
      }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template("create")
      end
    end
  end

  describe 'DELETE #destroy' do
    before { answer }
    it "deletes answer" do
      expect { delete :destroy, params: { id: answer, question_id: question }, format: :js }.to change(Answer, :count).by(-1)
    end

    it "redirects to the question" do
      delete :destroy, params: { id: answer, question_id: question }, format: :js
      expect(response).to render_template("destroy")
    end
  end
end
