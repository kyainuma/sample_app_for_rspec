FactoryBot.define do
  factory :task do
    title { 'test' }
    content { 'test' }
    status { 0 }
    deadline { Date.today }   
    user
  end
end
