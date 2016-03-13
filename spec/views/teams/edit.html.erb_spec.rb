require 'rails_helper'

RSpec.describe "teams/edit", type: :view do
  before(:each) do
    @team = assign(:team, Team.create!(
      :name => "MyString",
      :description => "MyText",
      :available_credit => 1.5
    ))
  end

  it "renders the edit team form" do
    render

    assert_select "form[action=?][method=?]", team_path(@team), "post" do

      assert_select "input#team_name[name=?]", "team[name]"

      assert_select "textarea#team_description[name=?]", "team[description]"

      assert_select "input#team_available_credit[name=?]", "team[available_credit]"
    end
  end
end
