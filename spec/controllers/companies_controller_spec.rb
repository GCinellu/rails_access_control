require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:energy_super) {
    FactoryGirl.create(:energy_super)
  }

  let(:company_attributes) {
    FactoryGirl.build(:energy_super, name: 'General Company').attributes
  }

  let(:company_attributes_invalid) {
    FactoryGirl.build(:energy_super, name: '').attributes
  }

  let(:owner) {
    FactoryGirl.create(:owner)
  }

  let(:front_end) {
    FactoryGirl.create(:front_end)
  }

  let(:owner_attributes) {
    { email: 'owner@itbank.com', password: 'password' }
  }

  let(:owner_invalid_email) {
    FactoryGirl.build(:owner, email: 'invalid_email').attributes
  }

  describe "GET #index" do
    context "when not authenticated" do
      it "should redirect to sign in" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated as owner" do
      login_owner
      it "should redirect to sign in" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated as administrator" do
      login_administrator
      it "should return http code ok" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "without authentication" do
      it "should not assigns the requested company as @company" do
        get :show, {:id => energy_super.id}
        expect(assigns(:company)).to eq(nil)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new company as @company" do
      get :new, company_attributes
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "GET #edit" do
    context "without being authenticated" do
      it "should not assigns the requested company as @company" do
        get :edit, {:id => energy_super.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "without having an authentication level high enough" do
      it "should not assigns the requested company as @company" do
        get :edit, {:id => front_end.company.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "being an administrator" do
      login_administrator
      it "should assigns the requested company as @company" do
        get :edit, {:id => energy_super.id}
        expect(assigns(:company)).to eq(energy_super)
      end
    end

    context "being the owner of the company" do
      it "should assigns the requested company as @company" do
        get :edit, {:id => owner.company.id}
        expect(assigns(:company)).to eq(owner.company)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "should create a new Company" do
        params = { user: owner_attributes, company: company_attributes }
        expect {
          post :create, params
        }.to change(Company, :count).by(1)
      end

      it "should create a user of the company" do
        params = { user: owner_attributes, company: company_attributes }
        expect {
          post :create, params
        }.to change(User, :count).by(1)

        expect(User.last.company).to eq(Company.last)
        expect(User.last.roles.include?('owner')).to eq(true)
      end

      it "assigns a newly created company as @company" do
        params = { user: owner_attributes, company: company_attributes }
        post :create, params
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it "assigns a newly created company's owner as @owner" do
        params = { user: owner_attributes, company: company_attributes }
        post :create, params
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created company" do
        params = { user: owner_attributes, company: company_attributes }
        post :create, params
        expect(response).to redirect_to(Company.last)
      end
    end

    context "with invalid params" do
      it "should not create a new Company" do
        params = { user: owner_attributes, company: company_attributes_invalid }

        expect {
          post :create, params
        }.not_to change(Company, :count)
      end

      it "should not create the owner of the company" do
        params = { user: owner_invalid_email, company: company_attributes }

        expect {
          post :create, params
        }.not_to change(User, :count)
      end
    end
  end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => new_attributes}, valid_session
  #       company.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "assigns the requested company as @company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => valid_attributes}, valid_session
  #       expect(assigns(:company)).to eq(company)
  #     end
  #
  #     it "redirects to the company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => valid_attributes}, valid_session
  #       expect(response).to redirect_to(company)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns the company as @company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => invalid_attributes}, valid_session
  #       expect(assigns(:company)).to eq(company)
  #     end
  #
  #     it "re-renders the 'edit' template" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   it "destroys the requested company" do
  #     company = Company.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => company.to_param}, valid_session
  #     }.to change(Company, :count).by(-1)
  #   end
  #
  #   it "redirects to the companies list" do
  #     company = Company.create! valid_attributes
  #     delete :destroy, {:id => company.to_param}, valid_session
  #     expect(response).to redirect_to(companies_url)
  #   end
  # end

end
