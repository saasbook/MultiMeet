require 'rails_helper'

RSpec.describe ProjectTime, type: :model do
  it "allows us to create a project date under project" do
    # create a project
    project = create(:project)

    # create a project date under project
    projectDate = project.project_times.create(
        is_date: true,
        date_time: Date.parse("Dec 1 2019"))

    expect(projectDate.project_id).to eq(1)
  end

  it "allows us to create a project time under project" do
    # create a project
    project = create(:project)

    # create a project time under project
    projectTime = project.project_times.create(
        is_date: true,
        date_time: Time.parse("Dec 1 2019 10:00 AM"))

    expect(projectTime.project_id).to eq(1)
  end
end
