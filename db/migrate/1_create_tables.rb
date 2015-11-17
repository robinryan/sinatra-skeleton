class CreateTables < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.string :phone
      t.string :password
      t.timestamps
    end

    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.references :user
      t.timestamps
    end

  end

end