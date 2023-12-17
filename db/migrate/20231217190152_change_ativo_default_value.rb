class ChangeAtivoDefaultValue < ActiveRecord::Migration[7.1]
  def change
    change_column_default :municipes, :ativo, from: nil, to: true
  end
end
