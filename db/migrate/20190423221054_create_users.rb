class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name, null: false, limit: 100, index: {unique: true}
      t.string :full_name
      t.string :email, index: {unique: true}
      t.string :password_digest
      t.text :settings, null: false, default: '{}'

      t.timestamps
    end
  end
end
