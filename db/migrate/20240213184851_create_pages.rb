class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string  :name
      t.string  :title
      t.string  :body
      t.string  :path
      t.integer :parent_id, null: true, index: true

      t.timestamps
    end
  end
end
