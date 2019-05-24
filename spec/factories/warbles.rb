FactoryBot.define do
  factory :warble do
    body { 'this is a warble :)' }
    #We know that warbles have a user/author association
    #Really easy to make that with factory bot
    association :author, factory: :user
  end
end