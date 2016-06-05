class AddDetailsToPpuser < ActiveRecord::Migration
  def change
    
    add_column :ppusers, :user_name, :string
    add_column :ppusers, :nick_name, :string
    add_column :ppusers, :identify_type, :string
    add_column :ppusers, :matching_number, :integer
  
  end
end
