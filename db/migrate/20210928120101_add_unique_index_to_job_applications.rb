class AddUniqueIndexToJobApplications < ActiveRecord::Migration[6.1]
  def change
    add_index :job_applications, [:applicant_id, :job_id], unique: true
  end
end
