class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.boolean :read, default: false
      t.datetime :read_at

      t.timestamps
    end
  end
end
