class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|

      t.string :code
      t.string :university
      t.string :title
      t.string :release_date

      t.timestamps null: false
    end
  end
end
