defmodule Api.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Api.Repo

  use Api.Factories.CameraFactory
  use Api.Factories.UserFactory
end
