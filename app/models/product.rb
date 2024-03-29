# == Schema Information
#
# Table name: products
#
#  id            :bigint(8)        not null, primary key
#  code          :string(10)
#  name          :string(60)
#  serial_number :string(15)
#  price         :integer
#  category_id   :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  stock         :integer
#

class Product < ApplicationRecord
  belongs_to :category, optional: true
  before_save :attach_category
  before_validation :set_price_and_stock, on: :create
  before_validation :build_code, on: :create

  has_many :assemblies, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :materials, through: :assemblies
  has_many :manifests, dependent: :destroy
  has_many :manufactures, through: :manifests
  has_many :advertises, dependent: :destroy

  validates_presence_of :code
  validates_length_of :code, within: 4..10
  validates_uniqueness_of :code, on: :create

  validates_presence_of :name
  validates_length_of :name, within: 4..60

  validates_presence_of :serial_number
  validates_length_of :serial_number, within: 5..15

  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0

  private
  def attach_category
    if self.category_id == nil
      self.category = Category.friendly.find 'uncategorized'
    end
  end

  def set_price_and_stock
    unless self.price
      self.price = 0
    end
    self.stock = 0
  end

  def build_code
    first   = Time.current.strftime '%d%m%Y'
    mans    = Product.last ? Product.last.id : 0
    offset  = (mans + 1).to_s.rjust(5, "0")
    role    = '01'
    self.serial_number = first + offset + role
  end
end
