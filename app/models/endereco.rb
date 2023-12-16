class Endereco < ApplicationRecord
  before_validation :format_cep
  before_validation :format_uf

  belongs_to :municipe

  validates :municipe, presence: true
  validates :cep, presence: true, length: { is: 8 }
  validates :numero, presence: true
  validates :logradouro, presence: true
  validates :bairro, presence: true
  validates :cidade, presence: true
  validates :uf, presence: true, length: { is: 2 }

  private

  def format_cep
    self.cep = cep.try(:gsub, /[^0-9]/, '')
  end

  def format_uf
    self.uf = uf.try(:upcase)
  end
end
