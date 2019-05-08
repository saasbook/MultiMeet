class AddMatchDegreeToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :match_degree, :integer
  end
end
