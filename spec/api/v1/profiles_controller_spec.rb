require "rails_helper"

RSpec.describe 'Profile API', type: :request do
  describe 'GET /me' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:user) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id) }

      before { get "/api/v1/profiles/me.json", headers: { "Authorization": "Bearer #{access_token.token}", "Accept": "application/json" } }
      it 'returns 200 status if there is access_token' do
        expect(response.status).to eq 200
      end

       before { get "/api/v1/profiles/me.json", headers: { "Authorization": "Bearer #{access_token.token}", "Accept": "application/json" } }
      it 'returns 200 status if there is access_token' do
        expect(response.status).to eq 200
      end

      it "contains email" do
        expect(response.body).to be_json_eql(user.email.to_json).at_path('email')
      end

      it "contains id" do
        expect(response.body).to be_json_eql(user.id.to_json).at_path('id')
      end

      it "does not contain password" do
        expect(response.body).to_not have_json_path('password')
      end

      it "does not contain password" do
        expect(response.body).to_not have_json_path('encrypted_password')
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/me', params: options.fetch(:params, {}), headers: options.fetch(:headers, {})
    end
  end
end
