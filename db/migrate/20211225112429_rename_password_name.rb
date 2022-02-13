# frozen_string_literal: true

class RenamePasswordName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :paswword_digest, :pasword_digest
  end
end
