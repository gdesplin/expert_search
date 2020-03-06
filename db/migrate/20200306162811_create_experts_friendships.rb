class CreateExpertsFriendships < ActiveRecord::Migration[6.0]

  def change
    create_table :experts_friendships, id: false do |t|
      t.integer :expert_a_id
      t.integer :expert_b_id

      t.timestamps
    end
  end

end
