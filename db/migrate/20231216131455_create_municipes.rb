class CreateMunicipes < ActiveRecord::Migration[7.1]
  def change
    create_table :municipes do |t|
      t.string :nome, null: false
      t.string :cpf, null: false
      t.string :cns, null: false
      t.string :email, null: false
      t.date :data_nascimento, null: false
      t.string :telefone, null: false
      t.boolean :ativo, null: false

      t.timestamps
    end
  end
end
