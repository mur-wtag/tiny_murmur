class CreateMurmurs < ActiveRecord::Migration[8.0]
  def change
    create_table :murmurs do |t|
      t.belongs_to :author, null: false, index: true
      t.text :content, null: false
      t.bigint :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
