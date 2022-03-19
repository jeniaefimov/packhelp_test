# This migration comes from calculation (originally 20220318123130)
class AddCalculationUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :calculation_users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.decimal :total_orders_pln, precision: 10, scale: 3
      t.decimal :total_orders_eur, precision: 10, scale: 3, default: 0.0

      t.timestamps
    end
  end
end
