class CreateInitialTables < ActiveRecord::Migration
  def change
    # USERS
    create_table :users do |t|
      # default: t.primary_key :id => integer
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.timestamps
    end


    # PROJECTS
    # primary key: integer id
    # foreign key: username => users.username
    # duration: integer of number of minutes per project meeting
    create_table :projects do |t|
      # default: t.primary_key :id => integer
      t.string :project_name, null: false
      t.string :username, null: false
      t.integer :duration
    end

    # username => users.username
    add_foreign_key :projects, :users,
                    column: :username, primary_key: :username


    # PARTICIPANTS
    create_table :participants do |t|
      # default: t.primary_key :id => integer
      t.integer :project_id, null: false # :projects.id
      t.string :email, null: false
    end

    # for (project_id, email) as PKEY
    add_index :participants, [:project_id, :email], unique: true

    # PROJECT_DATES
    # primary key: integer id
    # foreign key: project_id => projects.id
    create_table :project_dates do |t|
      t.date :date, null: false
      t.integer :project_id, null: false
    end

    # project_id => projects.id
    add_foreign_key :project_dates, :projects

    # PROJECT_TIMES
    # primary key: integer id
    # foreign key: project_id => projects.id
    create_table :project_times do |t|
      # default: t.primary_key :id => integer
      t.integer :project_date_id, null: false
      t.timestamp :start_time, null: false
    end

    # project_date_id => project_dates.id
    add_foreign_key :project_times, :project_dates,
                    column: :project_date_id, primary_key: :id


    # PARTICIPANT_RANKED_TIMES
    # primary key: integer id
    # foreign key: participants.id
    #              project_times.id
    create_table :participant_ranked_times do |t|
      t.integer :ranking
      t.string :participant_id, null: false
      t.string :project_time_id, null: false
    end

    # TODO: ensure uniqueness of (participants.id, project_times.id)
    # participant_id => participants.id
    add_foreign_key :participant_ranked_times, :participants
    # project_time_id => project_times.id
    add_foreign_key :participant_ranked_times, :project_times
  end
end

