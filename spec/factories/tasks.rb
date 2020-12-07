FactoryBot.define do
  factory :task do
    sequence(:title, "title_1")
    content { 'content' }
    status { :todo }
    deadline { Date.today }   
    association :user
  end
end
