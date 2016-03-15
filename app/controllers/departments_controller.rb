class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:new, :edit]
  before_action :authenticate_user!

  # GET /departments
  # GET /departments.json
  def index
    return redirect_to new_user_session_path unless current_user.is_administrator?
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    return redirect_to new_user_session_path unless current_user.is_within_company?(@department.company)
  end

  # GET /departments/new
  def new
    if current_user.company != @company and not current_user.is_administrator?
      sign_out current_user
      return redirect_to new_user_session_path
    end

    return redirect_to company_path(@company) unless current_user.is_owner_or_admin?(@company)
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
    return redirect_to company_path(@department.company) unless current_user.is_owner_or_admin?(@department.company)
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:company_id, :name, :description, :credit)
    end
end
