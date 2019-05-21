class AddSecretIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :secret_id, :string
  end
end
