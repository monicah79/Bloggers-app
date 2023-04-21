# frozen_string_literal: true

# Adds foreign keys to the posts table for associations with other tables.
class AddForeignKeysToPosts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :author_id
  end
end
