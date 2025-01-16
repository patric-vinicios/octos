defmodule Api.FlopTest do
  use Api.DataCase, async: true

  import Ecto.Query

  alias Api.Flop
  alias Api.Users.User

  @moduletag :unit

  describe "call/1" do
    test "should return a flop data if all params are valid" do
      query = from(u in User)
      result = Flop.call(query, %{page: 1, page_size: 10}, User)

      assert {:ok,
              %{
                data: [],
                errors: [],
                page: 1,
                page_size: 10,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 0,
                total_pages: 0,
                has_next_page: false,
                has_previous_page: false
              }} == result
    end

    test "should return a flop data with errors if any param is invalid" do
      query = from(u in User)
      result = Flop.call(query, %{page: 1, page_size: 10, limit: -1}, User)

      assert {:error,
              %{
                current_page: nil,
                data: [],
                errors: [limit: [{"cannot combine multiple pagination types", []}]],
                has_next_page: false,
                has_previous_page: false,
                next_page: nil,
                page: nil,
                page_size: nil,
                previous_page: nil,
                total_count: nil,
                total_pages: nil
              }} == result
    end

    test "should return an error when `page` param is less or equal than 0" do
      query = from(u in User)
      assert {:error, "`page` param must be higher than 0"} == Flop.call(query, %{page: 0}, User)
      assert {:error, "`page` param must be higher than 0"} == Flop.call(query, %{page: -1}, User)
    end

    test "should return an error when `page_size` param is less or equal than 0" do
      query = from(u in User)

      assert {:error, "`page_size` param must be higher than 0"} ==
               Flop.call(query, %{page_size: 0}, User)

      assert {:error, "`page_size` param must be higher than 0"} ==
               Flop.call(query, %{page_size: -1}, User)
    end
  end
end
