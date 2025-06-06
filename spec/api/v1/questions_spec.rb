require "rails_helper"

RSpec.describe 'Questions API', type: :request do
  describe "GET /index" do
    # let!(:do_request) { get '/api/v1/questions' }

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:user) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
      let!(:questions) { create_list(:question, 2) }
      let!(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before { get "/api/v1/questions", headers: { "Authorization": "Bearer #{access_token.token}", "Accept": "application/json" } }
      it 'returns 200 status if there is access_token' do
        expect(response.status).to eq 200
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2)
      end

      %w[id title body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      it "question object contains short_title" do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title")
      end

      context "answers" do
        it "included in question object" do
          expect(response.body). to have_json_size(1).at_path("0/answers")
        end

        %w[id body created_at updated_at].each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/me', params: options.fetch(:params, {}), headers: options.fetch(:headers, {})
    end
  end
end
