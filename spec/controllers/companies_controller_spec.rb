require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  ####### TODO Ensure authentication for owner testing works

  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  # let(:energy_super) {
  #   FactoryGirl.build(:energy_super)
  # }

  # let(:energy_super_modified) {
  #   FactoryGirl.create(:energy_super)
  # }

  let(:company_attributes) {
    FactoryGirl.build(:energy_super, name: 'General Company').attributes
  }

  let(:company_attributes_invalid) {
    FactoryGirl.build(:energy_super, name: '').attributes
  }

  let(:company_attributes_modified) {
    FactoryGirl.build(:energy_super, name: 'Energy Super modified').attributes
  }

  let(:administrator) {
    FactoryGirl.build(:administrator)
  }

  let(:administrator_attributes) {
    FactoryGirl.build(:administrator).attributes
  }

  let(:owner) {
    FactoryGirl.build(:energy_super_owner).attributes
  }

  let(:front_end) {
    FactoryGirl.build(:energy_super_front_end)
  }

  let(:front_end_attributes) {
    { email: 'frontend2@itbank.com', password: 'password' }
  }

  let(:owner_attributes) {
    { email: 'owner2@itbank.com', password: 'password' }
  }

  let(:owner_invalid_email) {
    FactoryGirl.build(:energy_super_owner, email: 'invalid_email').attributes
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
      it "should redirect to companies_path" do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    context "without authentication" do
      it "should not assigns the requested company as @company" do
        company = FactoryGirl.create(:energy_super, name: 'Test Company')
        get :show, {:id => company.id}

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
        company = FactoryGirl.create(:energy_super, name: 'Test Company')
        get :edit, {:id => company.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "without having an authentication level high enough" do
      login_front_end
      it "should not assigns the requested company as @company" do
        get :edit, {:id => @company.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "being an administrator" do
      login_administrator
      it "should assigns the requested company as @company" do
        company = FactoryGirl.create(:energy_super, name: 'Test Company')
        get :edit, {:id => company.id}
        expect(response).to have_http_status(200)
      end
    end

    context "being the owner of the company" do
      login_owner
      it "should assigns the requested company as @company" do
        get :edit, {:id => @company.id}
        expect(response).to have_http_status(200)
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

  describe "PUT #update" do
    login_administrator
    context "when authenticated as Administrtor" do
      it "should update the record" do
        company = FactoryGirl.create(:energy_super, name: 'Test Company')
        put :update, {:id => company.id, :company => company_attributes_modified }, cookies
        expect(response).to redirect_to(company)
      end
    end

    context "when authenticated as Owner" do
      login_owner
      context "with valid params" do
        it "updates the requested company" do
          put :update, {:id => @company.to_param, :company => company_attributes_modified}
          @company.reload

          expect(response).to redirect_to(@company)
          expect(response).to have_http_status(302)
        end

        it "assigns the requested company as @company" do
          put :update, {:id => @company.to_param, :company => company_attributes_modified}
          expect(assigns(:company)).to eq(@company)
        end
      end
    end

    context "with invalid params" do
      login_owner
      it "should not assigns the company as @company" do
        put :update, {:id => @company.to_param, :company => company_attributes_invalid}
        expect(assigns(:company)).to eq(@company)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => @company.to_param, :company => company_attributes_invalid}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    context "as Onwer" do
      login_owner
      it "destroys the requested company" do
        expect {
          delete :destroy, {:id => @company.to_param}
        }.to change(Company, :count).by(-1)
      end
    end

    context "as Developer" do
      login_front_end
      it "destroys the requested company" do
        delete :destroy, {:id => @company.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "as Administrator" do
      login_administrator
      it "destroys the requested company" do
        company = FactoryGirl.create(:energy_super, name: 'Test Company')

        expect {
          delete :destroy, {:id => company.to_param}
        }.to change(Company, :count).by(-1)
      end

      it "redirects to the companies list" do
        company = FactoryGirl.create(:energy_super, name: 'Test Company')
        delete :destroy, {:id => company.to_param}

        expect(response).to redirect_to(companies_url)
      end
    end
  end

end
