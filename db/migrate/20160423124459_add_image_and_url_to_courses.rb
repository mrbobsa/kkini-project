class AddImageAndUrlToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :image, :string
    add_column :courses, :url, :string
  end
end
