# json.array! @users # calls to_array on a var
# @users.each do |user|
#   json.set! user.id do 
#     # set! will set wtvr is in the block to the key of user.id
#     # json.set! user.name do
#     json.id user.id 
#     # ^ json.id is setting id as the key pointing to user.id
#     json.name user.name
#     # end
#   end
# end

# @users.each do |user|
#   json.set! user.id do
#     json.extract! user, :id, :name
#     # extract! is taking the first argument (user) 
#     # and gets the info from it. (:id, :name, etc)
#     # these are getting called on the user key. so we can also call 
#     # methods like associations.
#   end
# end
json.users do
  @users.each do |user|
    json.set! user.id do
      json.partial! 'api/users/user', user: user
      # this is getting all the info from the partial '_user'
    end
  end
end

json.locations do 
# create this key. value will be everything in the block.
  @users.each do |user|
    json.set! user.location.id do
      json.extract! user.location, :id, :name
    end
  end
end
