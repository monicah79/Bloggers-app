class AddConfirmableToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :confirmed_at)
      add_column :users, :confirmation_token, :string
      add_index :users, :confirmation_token, unique: true
      add_column :users, :confirmed_at, :datetime
    end
  end
end
