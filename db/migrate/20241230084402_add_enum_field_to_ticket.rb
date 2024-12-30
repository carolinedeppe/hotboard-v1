class AddEnumFieldToTicket < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :state, :integer, default: 0, null: false
  end
end