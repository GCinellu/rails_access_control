require 'rails_helper'

RSpec.describe "departments/new", type: :view do
  before(:each) do
    assign(:department, Department.new(
      :company => nil,
      :name => "MyString",
      :description => "MyText",
      :credit => 1.5
    ))
  end

  it "renders new department form" do
    render

    assert_select "form[action=?][method=?]", departments_path, "post" do

      assert_select "input#department_company_id[name=?]", "department[company_id]"

      assert_select "input#department_name[name=?]", "department[name]"

      assert_select "textarea#department_description[name=?]", "department[description]"

      assert_select "input#department_credit[name=?]", "department[credit]"
    end
  end
end
