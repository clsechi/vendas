class Customer < ApplicationRecord

  validates :name, :address, :email , presence: true
  validates :cpf, :phone, :birth_date, presence: true, if: :legal_person?
  validates :cnpj, :contact, presence: true, unless: :legal_person?

  def legal_person?
    cnpj.blank?
  end

end
