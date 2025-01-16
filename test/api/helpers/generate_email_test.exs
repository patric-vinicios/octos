defmodule Api.Helpers.GenerateEmailTest do
  use Api.DataCase, async: true

  import Mox

  setup :verify_on_exit!

  @moduletag :unit

  describe "call/1" do
    test "should return a generated email" do
      expect(Api.Helpers.GenerateEmailMock, :call, fn "Tony", "Stark" ->
        {:ok, "tony_stark42@gmail.com"}
      end)

      response = Api.Helpers.GenerateEmailMock.call("Tony", "Stark")

      assert {:ok, "tony_stark42@gmail.com"} == response
    end
  end
end
