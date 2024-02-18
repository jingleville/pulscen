class AddPageToPages < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :pages, :pages, column: :parent_id
  end
end
