class CreateFieldTypes < ActiveRecord::Migration
  def change
    create_table :field_types do |t|
      t.string :name
      t.string :data_type
      t.string :valid_regex

      t.timestamps null: false
    end
  end
end
