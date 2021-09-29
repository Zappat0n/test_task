class CreateJobApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :job_applications do |t|
      t.references :applicant, null: false, foreign_key: { to_table: :users}
      t.references :job, null: false, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
