require 'rails_helper'
include ActionCable::TestHelper

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe "GET #index" do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it "populates an array of all questions" do
      expect(assigns(:questions)).to match_array(questions)
    end

    it "renders index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, params: { id: question } }

    it "assigns the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "renders show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    sign_in_user

    before { get :new }

    it "assigns a new Question to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "builds new attachment for question" do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  # describe "GET #edit" do
  #   sign_in_user

  #   before { get :edit, params: { id: question } }

  #   it "assigns the requested question to @question" do
  #     expect(assigns(:question)).to eq question
  #   end

  #   it "renders edit view" do
  #     expect(response).to render_template :edit
  #   end
  # end

  describe "POST #create" do
    sign_in_user

    context "with valid attributes" do
      it 'saves tne new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it "redirects to show view" do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it "broadcasts a new question" do
        expect {
          post :create, params: { question: attributes_for(:question) }
        }.to have_broadcasted_to("questions")
      end
    end

    context "with invalid attributes" do
      it 'does not save tne question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it "re-renders new view" do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  # describe "PATCH #update" do
  #   sign_in_user

  #   context "with valid attributes" do
  #     it "assigns the requested question to @question" do
  #       patch :update, params: { id: question, question: attributes_for(:question) }
  #       expect(assigns(:question)).to eq question
  #     end

  #     it "changes question attributes" do
  #       patch :update, params: { id: question, question: { title: "new title", body: "new body" } }
  #       question.reload
  #       expect(question.title).to eq 'new title'
  #       expect(question.body).to eq 'new body'
  #     end

  #     it "redirects to the updated question" do
  #       patch :update, params: { id: question, question: attributes_for(:question) }
  #       expect(response).to redirect_to question
  #     end
  #   end

  #   context "with invalid attributes" do
  #     before { patch :update, params: { id: question, question: { title: "new title", body: nil } } }
  #     it "does not changes question attributes" do
  #       question.reload
  #       expect(question.title).to eq 'MyString'
  #       expect(question.body).to eq 'MyText'
  #     end

  #     it "re-renders edit view" do
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  describe "DELETE #destroy" do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
      question
    end

    before { question }
    it "deletes question" do
      expect { delete :destroy, params: { id: question.id } }.to change(Question, :count).by(-1)
    end

    it "redirect to index view" do
      delete :destroy, params: { id: question.id }
      expect(response).to redirect_to questions_path
    end
  end
end
