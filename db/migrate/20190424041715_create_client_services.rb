class CreateClientServices < ActiveRecord::Migration[5.2]
  def change
    create_table :client_services do |t|
      t.string :title, null: false
      t.text :description
      t.text :secret_key, null: false
      t.text :remote_public_key
      t.string :algorithm, null: false, limit: 50, default: 'HS256'
      t.integer :token_timeout
      t.datetime :expire_at
      t.boolean :suspended, null: false, default: false
      t.references :tag, index: true, foreign_key: {on_delete: :nullify}
      t.text :login_redirect
      t.text :logout_redirect
      t.boolean :require_signed_request, null: false, default: false
      t.boolean :force_login, null: false, default: false
      t.text :login_css
      t.timestamps
    end
  end
end
