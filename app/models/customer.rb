class Customer < ApplicationRecord
  has_many :orders

  validates :name, :address, :email, presence: true
  validates :cpf, :phone, :birth_date, presence: true, if: :legal_person?
  validates :cnpj, :contact, presence: true, unless: :legal_person?
  validates :email, :cpf, :cnpj, uniqueness: true

  def legal_person?
    cnpj.blank?
  end
end
