class CreateTagMutexes < ActiveRecord::Migration[5.2]
  def up
    create_table :tag_mutexes do |t|
      t.integer :tag_a_id, null: false
      t.integer :tag_b_id, null: false
    end
    add_index(:tag_mutexes, [:tag_a_id, :tag_b_id], unique: true, name: 'idx_user_tags_mutex')
  end

  def down
    drop_table :tags_mutex
  end
end
