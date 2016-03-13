require 'rails_helper'

RSpec.describe "wishes/show", type: :view do
  before(:each) do
    @wish = assign(:wish, Wish.create!(
      :team => nil,
      :title => "Title",
      :description => "MyText",
      :impact_on_business => 1,
      :time_required => 2,
      :ease_of_development => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
