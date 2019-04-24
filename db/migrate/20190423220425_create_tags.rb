class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :code, null: false
      t.string :title, null: false
      t.text :description
      t.boolean :immutable, null: false, default: false
      t.boolean :grants_admin, null: false, default: false
      t.boolean :apply_only_by_admin, null: false, default: false
      t.boolean :apply_by_default, null: false, default: false

      t.timestamps
    end
  end
end
