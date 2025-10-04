class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.belongs_to :follower, index: true, null: false
      t.belongs_to :followed, index: true, null: false

      t.timestamps
    end
  end
end
