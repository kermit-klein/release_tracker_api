class CreateUserSelections < ActiveRecord::Migration[6.0]
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS hstore'
    create_table :user_selections do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
