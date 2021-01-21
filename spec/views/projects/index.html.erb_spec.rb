require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        nickname: "Nickname"
      ),
      Project.create!(
        nickname: "Nickname"
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", text: "Nickname".to_s, count: 2
  end
end
