# frozen_string_literal: true

# add password digest
class AddPasswordDigest < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :paswword_digest, :string
  end
end
