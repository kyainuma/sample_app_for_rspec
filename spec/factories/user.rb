FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'test' }
    password_confirmation { 'test' }
  end
end
