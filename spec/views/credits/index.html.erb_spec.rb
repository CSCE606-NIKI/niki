require 'rails_helper'

RSpec.describe "credits/index", type: :view do
  before(:each) do
    assign(:credits, [
      Credit.create!(
        creditID: 2,
        status: "Status",
        type: "Type",
        credit_value: 3,
        description: "MyText"
      ),
      Credit.create!(
        creditID: 2,
        status: "Status",
        type: "Type",
        credit_value: 3,
        description: "MyText"
      )
    ])
  end

  it "renders a list of credits" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
