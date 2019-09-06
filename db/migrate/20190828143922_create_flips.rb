class CreateFlips < ActiveRecord::Migration[5.2]
  def change
    create_table :flips do |t|
      t.string :body, null: false

      t.timestamps
    end
  end
end
