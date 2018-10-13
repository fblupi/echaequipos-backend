FactoryBot.define do
  factory :v1_user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    confirmed_at { Date.today.at_beginning_of_day }
    phone_number { Faker::PhoneNumber.cell_phone }
    birth_date { Faker::Date.birthday(18, 65) }
    admin { false }
    jti { '103c0f90-807d-4da5-a431-23b277297a23' }
  end
end
