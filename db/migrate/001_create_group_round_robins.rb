class CreateGroupRoundRobins < ActiveRecord::Migration
  def change
    create_table :group_round_robins do |t|
    	t.integer :group_id, :null => false
    	t.boolean :is_active, :null => false, :default => false
    	t.boolean :is_weighted, :null => false, :default => false
    	t.integer :last_user, :null => true
    end
  end
end
