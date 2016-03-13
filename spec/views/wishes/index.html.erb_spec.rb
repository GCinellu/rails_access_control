require 'rails_helper'

RSpec.describe "wishes/index", type: :view do
  before(:each) do
    assign(:wishes, [
      Wish.create!(
        :team => nil,
        :title => "Title",
        :description => "MyText",
        :impact_on_business => 1,
        :time_required => 2,
        :ease_of_development => 3
      ),
      Wish.create!(
        :team => nil,
        :title => "Title",
        :description => "MyText",
        :impact_on_business => 1,
        :time_required => 2,
        :ease_of_development => 3
      )
    ])
  end

  it "renders a list of wishes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
