class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false, length: { maximum: 255 }
      t.boolean :is_global, default: false

      t.timestamps
    end
  end
end
