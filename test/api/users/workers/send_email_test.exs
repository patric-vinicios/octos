defmodule Api.Users.Workers.SendEmailTest do
  use Api.DataCase, async: true

  use Oban.Testing, repo: Api.Repo

  alias Api.Users.Workers.SendEmail

  @moduletag :unit

  describe "perform/1" do
    test "when has all parameters, perform the job" do
      %{id: user_id} = insert(:user, %{email: "customer@octos.ai"})
      %{id: user2_id} = insert(:user, %{email: "customer2@octos.ai"})

      insert(:camera, %{brand_name: "Hikvision", user_id: user_id})
      insert(:camera, %{brand_name: "Hikvision", user_id: user2_id})

      assert :ok == perform_job(SendEmail, %{})
    end
  end
end
