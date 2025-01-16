defmodule Api.Users.EnumsTest do
  use Api.DataCase, async: true

  alias Api.Users.Enums

  @moduletag :unit

  describe "Enums" do
    test "Should return a list of allowed enums" do
      assert [:active, :inactive] == Enums.users_status()
    end
  end
end
