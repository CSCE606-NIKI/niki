require 'rails_helper'

RSpec.describe "credits/edit", type: :view do
  let(:credit) {
    Credit.create!(
      creditID: 1,
      status: "MyString",
      type: "",
      credit_value: 1,
      description: "MyText"
    )
  }

  before(:each) do
    assign(:credit, credit)
  end

  it "renders the edit credit form" do
    render

    assert_select "form[action=?][method=?]", credit_path(credit), "post" do

      assert_select "input[name=?]", "credit[creditID]"

      assert_select "input[name=?]", "credit[status]"

      assert_select "input[name=?]", "credit[type]"

      assert_select "input[name=?]", "credit[credit_value]"

      assert_select "textarea[name=?]", "credit[description]"
    end
  end
end
