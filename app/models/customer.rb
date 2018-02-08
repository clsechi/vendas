class Customer < ApplicationRecord
  has_many :orders

  validates :name, :address, :email, presence: true
  validates :cpf, :phone, :birth_date, :email, presence: true, uniqueness: true, if: :legal_person?
  validates :cnpj, :contact, :email, presence: true, uniqueness: true, unless: :legal_person?

  def legal_person?
    cnpj.blank?
  end
end
