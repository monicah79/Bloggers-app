# frozen_string_literal: true

# Adds index  to the comments table for associations with other tables.
class AddIndexToComments < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, :post_id
  end
end
