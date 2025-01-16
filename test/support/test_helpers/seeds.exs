alias Api.Cameras.Camera
alias Api.Users.User
alias Api.Repo

Repo.delete_all(Camera)
Repo.delete_all(User)

# cameras = ["Intelbras", "Hikvision", "Giga", "Vivotek"]

# statuses = [:active, :inactive]

# {:ok, timestamp} = NaiveDateTime.new(Date.utc_today(), Time.utc_now())
# timestamp = NaiveDateTime.truncate(timestamp, :second)

# Enum.each(1..2, fn _ ->
#   user_status = Enum.random(statuses)
#   user =
#     case user_status do
#       :inactive -> %User{name: Faker.Person.first_name(), status: :inactive, inactivated_at: Date.utc_today()}
#       :active -> %User{name: Faker.Person.first_name(), status: :active}
#     end

#   %{id: user_id, status: user_status} = Repo.insert!(user)

#   cameras = Enum.map(1..3, fn _ ->
#     camera_status = if user_status == :inactive, do: :inactive, else: Enum.random(statuses)

#     %{
#       brand_name: Enum.random(cameras),
#       status: camera_status,
#       user_id: user_id,
#       inserted_at: timestamp,
#       updated_at: timestamp
#     }
#   end)

#   Repo.insert_all(Camera, cameras)

# end)
