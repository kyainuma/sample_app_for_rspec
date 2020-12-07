FactoryBot.define do
  factory :task do
    title { 'test' }
    content { 'content' }
    status { :todo }
    deadline { Date.today }   
    association :user
  end
end
