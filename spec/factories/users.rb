FactoryBot.define do
  factory :user do
    name { "Test User" }
    username { "testuser" }
    email { "test@example.com" }
    password { "password123" }
  end
end
