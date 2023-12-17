class Municipe < ApplicationRecord
  before_save :normalize_telefone
  after_create :send_new_registration_email
  after_update :send_registration_updated_email

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

  def send_new_registration_email
    MunicipeMailer.with(municipe: self).new_registration.deliver_later
  end

  def send_registration_updated_email
    MunicipeMailer.with(municipe: self, saved_changes:).registration_updated.deliver_later
  end
end
