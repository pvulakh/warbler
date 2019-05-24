# partial

json.extract! user, :id, :name, :location_id
json.warble_ids user.warbles.pluck(:id)
# location_id is a active record method that calls the association
# and gets the id.

# json.location do 
#   json.extract! user.location, :id, :name
# end
# ^ dont want to do this! This is not normalized state!
