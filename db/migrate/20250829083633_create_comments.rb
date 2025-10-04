class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.belongs_to :murmur, null: false, index: true
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }, index: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
