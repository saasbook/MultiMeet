require 'rails_helper'

RSpec.describe Participant, type: :model do
  it "allows us to create a participant under project" do
    # create a project
    project = create(:project)

    # create a project date under project
    participant = project.participants.create(
        email: "student@berkeley.edu",
        last_responded: null)

    expect(participant.project_id).to eq(1)
  end
end
