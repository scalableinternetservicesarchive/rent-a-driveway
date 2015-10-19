class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :seller
      t.belongs_to :buyer
      t.belongs_to :listing
      t.timestamps null: false
    end
  end
end
