# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string(60)
#  slug       :string(60)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
