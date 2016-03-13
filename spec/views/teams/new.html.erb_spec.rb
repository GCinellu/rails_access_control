require 'rails_helper'

RSpec.describe "teams/new", type: :view do
  before(:each) do
    assign(:team, Team.new(
      :name => "MyString",
      :description => "MyText",
      :available_credit => 1.5
    ))
  end

  it "renders new team form" do
    render

    assert_select "form[action=?][method=?]", teams_path, "post" do

      assert_select "input#team_name[name=?]", "team[name]"

      assert_select "textarea#team_description[name=?]", "team[description]"

      assert_select "input#team_available_credit[name=?]", "team[available_credit]"
    end
  end
end
