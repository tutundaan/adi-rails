# == Schema Information
#
# Table name: delivery_orders
#
#  id         :bigint(8)        not null, primary key
#  number     :integer
#  order_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DeliveryOrder, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
