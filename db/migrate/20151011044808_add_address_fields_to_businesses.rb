class AddAddressFieldsToBusinesses < ActiveRecord::Migration
  def change
    remove_column :businesses, :address
    remove_column :businesses, :location 
    add_column :businesses, :add1, :string
    add_column :businesses, :add2, :string
    add_column :businesses, :city, :string
    add_column :businesses, :state, :string
    add_column :businesses, :zip, :string
    remove_column :customers, :location 
    add_column :customers, :add1, :string
    add_column :customers, :add2, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :zip, :string
  end
end
