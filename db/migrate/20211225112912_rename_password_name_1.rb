# frozen_string_literal: true

# migration for renaiming the password
class RenamePasswordName1 < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :pasword_digest, :password_digest
  end
end
