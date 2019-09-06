class AddAuthorIdToFlips < ActiveRecord::Migration[5.2]
  def change
    add_column :flips, :author_id, :integer
  end
end
