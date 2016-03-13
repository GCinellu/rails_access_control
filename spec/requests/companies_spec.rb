require 'rails_helper'

RSpec.describe "Companies", type: :request do
  describe "GET /companies" do
    context "when not authenticated" do
      it "should redirect to log in" do
        get companies_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
