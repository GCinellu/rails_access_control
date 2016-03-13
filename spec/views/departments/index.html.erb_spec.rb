require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    assign(:departments, [
      Department.create!(
        :company => nil,
        :name => "Name",
        :description => "MyText",
        :credit => 1.5
      ),
      Department.create!(
        :company => nil,
        :name => "Name",
        :description => "MyText",
        :credit => 1.5
      )
    ])
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
