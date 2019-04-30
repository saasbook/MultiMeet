# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'allows us to create a project under user' do
    # first create a user
    user = create(:user)

    # create a project under user
    project = user.projects.create(
      project_name: 'CS 169 IPM',
      duration: 30
    )

    expect(project.user_id).to eq(1)
    expect(project.user.username).to eq('jdoe')
  end
end
