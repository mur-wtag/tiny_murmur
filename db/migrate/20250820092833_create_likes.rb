class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :murmur, null: false, index: true

      t.timestamps
    end
  end
end
