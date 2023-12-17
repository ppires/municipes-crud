class Endereco < ApplicationRecord
  before_validation :normalize_cep
  before_validation :normalize_uf

  belongs_to :municipe

  validates :cep, presence: true, length: { is: 8 }
  validates :numero, presence: true
  validates :logradouro, presence: true
  validates :bairro, presence: true
  validates :cidade, presence: true
  validates :uf, presence: true, length: { is: 2 }

  def formatted
    "#{logradouro} #{numero}#{complemento.present? ? " #{complemento}" : ''}, #{bairro}, #{cidade}-#{uf}"
  end

  private

  def normalize_cep
    self.cep = cep.try(:gsub, /[^0-9]/, '')
  end

  def normalize_uf
    self.uf = uf.try(:upcase)
  end
end
