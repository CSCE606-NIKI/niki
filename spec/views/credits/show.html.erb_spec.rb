require 'rails_helper'

RSpec.describe "credits/show", type: :view do
  before(:each) do
    assign(:credit, Credit.create!(
      creditID: 2,
      status: "Status",
      type: "Type",
      credit_value: 3,
      description: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
  end
end
