require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      intime: 1,
      outtime: 1,
      project: nil
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[intime]"

      assert_select "input[name=?]", "task[outtime]"

      assert_select "input[name=?]", "task[project_id]"
    end
  end
end
