class Municipe < ApplicationRecord
  before_save :normalize_telefone

  has_one_attached :foto do |img|
    img.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :nome, com_sobrenome: { message: 'deve ter um sobrenome' }
  validates :cpf, cpf: true
  validates :cns, presence: true, cns: true
  validates :email, email: { mode: :strict }
  validates :data_nascimento, presence: true, reasonable_age: true, birthday_in_the_past: true
  validates :telefone, phone: true
  validates :ativo, inclusion: [true, false]

  private

  def normalize_telefone
    self.telefone = Phonelib.parse(telefone).full_e164.presence
  end
end
