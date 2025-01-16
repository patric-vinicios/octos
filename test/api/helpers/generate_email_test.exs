defmodule Api.Helpers.GenerateEmailTest do
  use Api.DataCase, async: true

  import Mox

  alias Api.Helpers.GenerateEmailMock

  setup :verify_on_exit!

  @moduletag :unit

  describe "call/1" do
    test "should return a generated email" do
      expect(GenerateEmailMock, :call, fn "Tony", "Stark" ->
        {:ok, "tony_stark42@gmail.com"}
      end)

      response = GenerateEmailMock.call("Tony", "Stark")

      assert {:ok, "tony_stark42@gmail.com"} == response
    end
  end
end
