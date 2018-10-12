FactoryBot.define do
  factory :v1_user, class: 'User' do
    email { Faker::Internet.email }
    password { 'password' }
    name { 'Name' }
    last_name { 'Surname' }
    confirmed_at { Date.today.at_beginning_of_day }
    phone_number { '123456789' }
    birth_date { '1994-09-12' }
    admin { false }
    jti { '103c0f90-807d-4da5-a431-23b277297a23' }
  end
end
