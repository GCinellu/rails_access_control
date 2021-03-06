require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe DepartmentsController, type: :controller do

  let(:departments_it_valid_attributes) {
    FactoryGirl.build(:departments_it).attributes
  }

  let(:departments_it_invalid_attributes) {
    FactoryGirl.build(:departments_it, name: '').attributes
  }

  describe "GET #index" do
    context "when not authenticated" do
      it "should redirect to the login page" do
        company = FactoryGirl.create(:energy_super, name: 'Test Company')
        get :index, {company_id: company.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated with privileges lower than administrator" do
      login_owner
      it "should redirect to the login page" do
        get :index, {company_id: @company.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated as administrator" do
      login_administrator
      it "should be able to access the resource" do
        get :index, {company_id: @company.id}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    context "when not authenticated" do
      it "should redirect to the login page" do
        company    = FactoryGirl.create(:energy_super, name: 'Test Company')
        department = company.departments.create(departments_it_valid_attributes)

        get :show, {company_id: company.id, id: department.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated within the same company" do
      login_front_end
      it "should assign the requested department as @department" do
        department = @company.departments.create(departments_it_valid_attributes)

        get :show, {company_id: @company.id, id: department.id}
        expect(response).to have_http_status(200)
      end
    end

    context "when authenticated from a different company" do
      login_stranger
      it "should redirect to the log in path" do
        department = @proper_company.departments.create(departments_it_valid_attributes)

        get :show, {company_id: @proper_company.id, id: department.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "GET #new" do
    context "when not authenticated" do
      it "should redirect to the login page" do
        company = FactoryGirl.create(:energy_super, name: 'New Department Company')

        get :new, {company_id: company.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when logged from within the same company" do
      context "when role is either manager or owner" do
        after(:each) do
          sign_out @owner
        end

        login_owner
        it "assign a new department to @department" do
          get :new, { company_id: @company.id }
          expect(assigns(:department)).to be_a_new(Department)
        end

        login_manager
        it "assign a new department to @department" do
          get :new, { company_id: @company.id }
          expect(assigns(:department)).to be_a_new(Department)
        end
      end

      context "when role is below manager" do
        login_front_end
        it "should redirect to the company's page" do
          get :new, { company_id: @company.id }
          expect(response).to redirect_to(company_path(@company))
        end
      end
    end

    context "when logged from an external company" do
      login_stranger
      it "should disconnect the user and send him to the login page" do
        get :new, { company_id: @proper_company.id }

        expect(session.empty?).to eq(true)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when logged as administrator" do
      login_administrator
      it "should redirect to the edit page" do
        get :new, { company_id: @company.id }
        expect(assigns(:department)).to be_a_new(Department)
      end
    end
  end

  describe "GET #edit" do
    context "when not authenticated" do
      it "should redirect to the login page" do
        company = FactoryGirl.create(:energy_super, name: 'Edit Department Company')
        department = company.departments.create(departments_it_valid_attributes)

        get :edit, {company_id: company.id, id: department.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated from within the same company" do
      context "when role is either manager or owner" do
        login_owner
        it "allows the user to see the edit page" do
          get :edit, { company_id: @company.id, id: @departments_it.id }
          expect(assigns(:department)).to eq(@departments_it)
        end
      end

      context "when role is below manager"
    end

    context "when logged from an external company"

    context "when logged as administrator"
  end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Department" do
  #       expect {
  #         post :create, {:department => valid_attributes}, valid_session
  #       }.to change(Department, :count).by(1)
  #     end
  #
  #     it "assigns a newly created department as @department" do
  #       post :create, {:department => valid_attributes}, valid_session
  #       expect(assigns(:department)).to be_a(Department)
  #       expect(assigns(:department)).to be_persisted
  #     end
  #
  #     it "redirects to the created department" do
  #       post :create, {:department => valid_attributes}, valid_session
  #       expect(response).to redirect_to(Department.last)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved department as @department" do
  #       post :create, {:department => invalid_attributes}, valid_session
  #       expect(assigns(:department)).to be_a_new(Department)
  #     end
  #
  #     it "re-renders the 'new' template" do
  #       post :create, {:department => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end
  #
  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested department" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => new_attributes}, valid_session
  #       department.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "assigns the requested department as @department" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => valid_attributes}, valid_session
  #       expect(assigns(:department)).to eq(department)
  #     end
  #
  #     it "redirects to the department" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => valid_attributes}, valid_session
  #       expect(response).to redirect_to(department)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns the department as @department" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => invalid_attributes}, valid_session
  #       expect(assigns(:department)).to eq(department)
  #     end
  #
  #     it "re-renders the 'edit' template" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   it "destroys the requested department" do
  #     department = Department.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => department.to_param}, valid_session
  #     }.to change(Department, :count).by(-1)
  #   end
  #
  #   it "redirects to the departments list" do
  #     department = Department.create! valid_attributes
  #     delete :destroy, {:id => department.to_param}, valid_session
  #     expect(response).to redirect_to(departments_url)
  #   end
  # end

end
