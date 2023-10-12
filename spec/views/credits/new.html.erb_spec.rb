require 'rails_helper'

RSpec.describe "credits/new", type: :view do
  before(:each) do
    assign(:credit, Credit.new(
      creditID: 1,
      status: "MyString",
      type: "",
      credit_value: 1,
      description: "MyText"
    ))
  end

  it "renders new credit form" do
    render

    assert_select "form[action=?][method=?]", credits_path, "post" do

      assert_select "input[name=?]", "credit[creditID]"

      assert_select "input[name=?]", "credit[status]"

      assert_select "input[name=?]", "credit[type]"

      assert_select "input[name=?]", "credit[credit_value]"

      assert_select "textarea[name=?]", "credit[description]"
    end
  end
end
