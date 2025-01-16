Mox.defmock(Api.Helpers.GenerateEmailMock, for: Api.Helpers.GenerateEmailBehaviour)
Application.put_env(:api, :call, Api.Helpers.GenerateEmailMock)

{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start()
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, :manual)
