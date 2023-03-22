class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :task_description
      t.string :task_status
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
