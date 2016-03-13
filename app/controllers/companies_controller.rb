class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new, :create]
  before_action :auth_administrator!, only: [:index, :edit]

  # GET /companies
  # GET /companies.json
  def index
    redirect_to new_user_session_path unless current_user.roles.include?('administrator')
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = current_user.company
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    raise current_user.roles.include?('owner').inspect and current_user.company == @company
    redirect_to new_user_session_path unless current_user.roles.include?('owner') and current_user.company == @company
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @user    = @company.users.build(user_params)
    @user.roles << 'owner'

    unless @company.save
      return render :new, notice: @company.errors.messages.merge(@user.errors.messages)
    end

    respond_to do |format|
      if sign_in @user
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, notice: 'Problem logging in' }
        format.json { render json: {errors: 'Problem logging in'}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :description)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def auth_administrator!
    redirect_to new_user_session_path unless current_user.roles.include?('administrator')
  end
end
