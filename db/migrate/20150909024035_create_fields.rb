class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.references :field_type, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
      t.boolean :required
      t.string :placeholder

      t.timestamps null: false
    end
  end
end
