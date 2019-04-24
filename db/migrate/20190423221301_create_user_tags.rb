class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|
      t.references :user, null: false, index: true, foreign_key: {on_delete: :cascade}
      t.references :tag, null: false, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
