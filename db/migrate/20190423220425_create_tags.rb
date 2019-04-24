class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :code
      t.string :title
      t.text :description
      t.boolean :immutable
      t.boolean :grants_admin
      t.boolean :apply_only_by_admin
      t.boolean :apply_by_default

      t.timestamps
    end
  end
end
