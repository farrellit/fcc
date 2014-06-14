class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :proceeding_number
      t.string :nameof_filer
      t.string :typeof_filing
      t.string :exparte
      t.date :data_received
      t.date :date_posted
      t.string :address
      t.decimal :view_id, precision: 12
      t.decimal :document_id, precision: 12
      t.string :view_url
      t.string :document_url
      t.text :comment

      t.timestamps
    end
  end
end
