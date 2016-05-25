class AddDetailsToPpuser < ActiveRecord::Migration
  def change
    
    add_column :ppusers, :user_name, :string, null: false
    add_column :ppusers, :nick_name, :string, null: false
    add_column :ppusers, :identify_type, :string, null: false
    add_column :ppusers, :matching_number, :integer, null: false
    
  end
end
