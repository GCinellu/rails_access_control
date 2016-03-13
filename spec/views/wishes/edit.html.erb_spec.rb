require 'rails_helper'

RSpec.describe "wishes/edit", type: :view do
  before(:each) do
    @wish = assign(:wish, Wish.create!(
      :team => nil,
      :title => "MyString",
      :description => "MyText",
      :impact_on_business => 1,
      :time_required => 1,
      :ease_of_development => 1
    ))
  end

  it "renders the edit wish form" do
    render

    assert_select "form[action=?][method=?]", wish_path(@wish), "post" do

      assert_select "input#wish_team_id[name=?]", "wish[team_id]"

      assert_select "input#wish_title[name=?]", "wish[title]"

      assert_select "textarea#wish_description[name=?]", "wish[description]"

      assert_select "input#wish_impact_on_business[name=?]", "wish[impact_on_business]"

      assert_select "input#wish_time_required[name=?]", "wish[time_required]"

      assert_select "input#wish_ease_of_development[name=?]", "wish[ease_of_development]"
    end
  end
end
