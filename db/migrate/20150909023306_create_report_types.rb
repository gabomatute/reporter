class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.references :database, index: true, foreign_key: true
      t.text :description
      t.text :sql

      t.timestamps null: false
    end
  end
end
