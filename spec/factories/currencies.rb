# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  code       :string(3)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :currency do
    code { "MyString" }
    user { nil }
  end
end