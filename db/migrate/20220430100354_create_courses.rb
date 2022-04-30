class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :subject
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :currency, null: false
      t.boolean :launch, default: false
      t.string :url, null: false
      t.text :description
      t.integer :expire_day, null: false 

      t.timestamps
    end
  end
end
