# frozen_string_literal: true

# add user id to article
class AddUserIdToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_id, :int
  end
end
