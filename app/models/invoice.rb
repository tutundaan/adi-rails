# == Schema Information
#
# Table name: invoices
#
#  id          :bigint(8)        not null, primary key
#  number      :string(16)
#  termin      :integer
#  currency_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :bigint(8)
#

class Invoice < ApplicationRecord
  belongs_to :currency
  belongs_to :order

  after_create :generate_sales_invoice

  enum termin: { "Tunai": 0, "30 Hari": 1, "60 Hari": 2, "90 Hari": 3 }
  before_create :build_number
  before_validation :set_termin

  validates_presence_of :termin

  private
  def build_number
    first   = Time.current.strftime '%d%m%Y'
    mans    = Invoice.last ? Invoice.last.id : 0
    offset  = '0' * (6 - mans.to_s.length)
    role    = '03'
    self.number = first + offset + (mans + 1).to_s + role
  end

  def set_termin
    if termin.nil?
      self.termin = 0
    end
  end

  def generate_sales_invoice
    unless cash?
      order.create_sales_invoice
    end
  end

  def cash?
    termin == 'Tunai'
  end
end
