alias Api.Cameras.Camera
alias Api.Helpers.GenerateEmail
alias Api.Repo
alias Api.Users.User

cameras = ["Intelbras", "Hikvision", "Giga", "Vivotek"]

statuses = [:active, :inactive]

{:ok, timestamp} = NaiveDateTime.new(Date.utc_today(), Time.utc_now())
timestamp = NaiveDateTime.truncate(timestamp, :second)

Repo.transaction(fn ->
  Enum.each(1..1_000, fn _ ->
    user_status = Enum.random(statuses)
    user_first_name = Faker.Person.first_name()
    user_last_name = Faker.Person.last_name()
    {:ok, user_email} = GenerateEmail.call(user_first_name, user_last_name)

    user =
      case user_status do
        :inactive ->
          %User{
            name: user_first_name,
            email: user_email,
            status: :inactive,
            inactivated_at: Date.utc_today()
          }

        :active ->
          %User{name: user_first_name, email: user_email, status: :active}
      end

    %{id: user_id, status: user_status} = Repo.insert!(user)

    cameras =
      Enum.map(1..50, fn _ ->
        camera_status = if user_status == :inactive, do: :inactive, else: Enum.random(statuses)

        %{
          brand_name: Enum.random(cameras),
          status: camera_status,
          user_id: user_id,
          inserted_at: timestamp,
          updated_at: timestamp
        }
      end)

    Repo.insert_all(Camera, cameras)
  end)
end)
