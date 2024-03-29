# == Schema Information
#
# Table name: depreciations
#
#  id          :bigint(8)        not null, primary key
#  note        :string(255)
#  amount      :integer
#  quantity    :integer
#  provider_id :bigint(8)
#  material_id :bigint(8)
#  user_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Depreciation < ApplicationRecord
  belongs_to :provider
  belongs_to :material
  belongs_to :user

  validates_presence_of :note
  validates_length_of :note, within: 6...255

  validates_presence_of :amount
  validates_numericality_of :amount, greater_than_or_equal_to: 1

  validates_presence_of :quantity
  validates_numericality_of :quantity, greater_than_or_equal_to: 1
end
