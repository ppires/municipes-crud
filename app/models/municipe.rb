class Municipe < ApplicationRecord
  before_save :normalize_telefone, :normalize_cpf, :normalize_cns
  after_create :notify_new_registration
  after_update :notify_updated_status, if: :status_changed?

  has_one :endereco, dependent: :destroy, required: true, inverse_of: :municipe
  has_one_attached :foto do |img|
    img.variant :thumb, resize_to_limit: [100, 100]
  end

  accepts_nested_attributes_for :endereco

  validates :nome, com_sobrenome: { message: 'deve ter um sobrenome' }
  validates :cpf, cpf: true
  validates :cns, presence: true, cns: true
  validates :email, email: { mode: :strict }
  validates :data_nascimento, presence: true, reasonable_age: true, birthday_in_the_past: true
  validates :telefone, phone: true
  validates :ativo, inclusion: [true, false]
  validates :foto, presence: true

  def formatted_cpf
    CPF.new(cpf).formatted
  end

  def formatted_cns
    cns.to_s.gsub(/[^\d]/, '').gsub(/\A(\d{3})(\d{4})(\d{4})(\d{4})\Z/, '\\1 \\2 \\3 \\4')
  end

  def formatted_endereco
    endereco.formatted
  end

  private

  def normalize_telefone
    self.telefone = Phonelib.parse(telefone).full_e164.presence
  end

  def normalize_cpf
    cpf.gsub(/[^\d]/, '')
  end

  def normalize_cns
    cpf.gsub(/[^\d]/, '')
  end

  def status_changed?
    saved_changes.key?(:ativo)
  end

  def notify_new_registration
    send_new_registration_email
    send_new_registration_sms
  end

  def notify_updated_status
    send_status_updated_email
    send_status_updated_sms
  end

  def send_new_registration_email
    MunicipeMailer.with(municipe: self).new_registration.deliver_later
  end

  def send_status_updated_email
    MunicipeMailer.with(municipe: self, saved_changes: saved_changes[:ativo]).status_updated.deliver_later
  end

  def send_new_registration_sms
    SendSmsJob.perform_later(id, 'Suas informações foram cadastradas na plataforma Municipe CRUD.')
  end

  def send_status_updated_sms
    action = ativo? ? 'ativado' : 'desativado'
    SendSmsJob.perform_later(id, "Seu cadastro foi #{action} na plataforma Municipe CRUD.")
  end
end
