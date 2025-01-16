defmodule Api.Cameras.EnumsTest do
  use Api.DataCase, async: true

  alias Api.Cameras.Enums

  @moduletag :unit

  describe "Enums" do
    test "Should return a list of allowed enums" do
      assert [:active, :inactive] == Enums.cameras_status()
    end
  end
end
