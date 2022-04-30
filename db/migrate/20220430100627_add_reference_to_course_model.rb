class AddReferenceToCourseModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :category
  end
end
