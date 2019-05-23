class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text :avatar_url
      t.text :html_url
      t.string :location

      t.timestamps
    end
  end
end
