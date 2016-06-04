class AddDetailsToPpuser < ActiveRecord::Migration
  def self.up
    
    add_column :ppusers, :user_name, :string
    add_column :ppusers, :nick_name, :string
    add_column :ppusers, :identify_type, :string
    add_column :ppusers, :matching_number, :integer
    
    Ppuser.reset_column_information
 
    Ppuser.all.each do |ppuser|
      ppuser.user_name = ppuser.created_at
      ppuser.nick_name = ppuser.created_at
      ppuser.identify_type = ppuser.created_at
      ppuser.matching_number = ppuser.created_at
      ppuser.save!
    end
 
    change_column :ppusers, :user_name, :string, :null => false
    change_column :ppusers, :nick_name, :string, :null => false
    change_column :ppusers, :identify_type, :string, :null => false
    change_column :ppusers, :matching_number, :string, :null => false
    
  end
  
  def self.down
    remove_column :ppusers, :user_name
    remove_column :ppusers, :nick_name
    remove_column :ppusers, :identify_type
    remove_column :ppusers, :matching_number
  end
  
end
