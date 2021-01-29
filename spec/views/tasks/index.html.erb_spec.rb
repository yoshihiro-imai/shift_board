require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        intime: 2,
        outtime: 3,
        project: nil
      ),
      Task.create!(
        intime: 2,
        outtime: 3,
        project: nil
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
