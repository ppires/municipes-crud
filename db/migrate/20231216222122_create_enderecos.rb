class CreateEnderecos < ActiveRecord::Migration[7.1]
  def change
    create_table :enderecos do |t|
      t.references :municipe, null: false, foreign_key: true
      t.string :cep, null: false
      t.string :logradouro, null: false
      t.string :numero, null: false
      t.string :complemento
      t.string :bairro, null: false
      t.string :cidade, null: false
      t.string :uf, null: false
      t.string :codigo_ibge

      t.timestamps
    end
  end
end
