defmodule ApiWeb.Graphql.Schema.Schema.Query.User do
  use ApiWeb.ConnCase

  @moduletag :integration

  describe "query: list user" do
    test "should return a user by his name", %{conn: conn} do
      %{id: user_id} = insert(:user)
      %{id: _user2_id} = insert(:user, %{email: "another_email@octos.ai", name: "Tony Stark"})

      insert(:camera, %{user_id: user_id})

      query = """
        {
          list(params: {
            pageSize: 10
            page: 1
            filters: [
              {
                field: "name"
                value: "John Doe"
                op: "=="
              }
            ]
          }) {
            data {
              id
              name
            }
        }}
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{"list" => %{"data" => [%{"id" => user_id, "name" => "John Doe"}]}}
             } == response
    end

    test "should return an user by camera's name brand", %{conn: conn} do
      %{id: _user_id} = insert(:user)
      %{id: user2_id} = insert(:user, %{email: "another_email@octos.ai", name: "Tony Stark"})

      insert(:camera, %{user_id: user2_id, brand_name: "Octos"})

      query = """
        {
          list(params: {
            pageSize: 10
            page: 1
            filters: [
              {
                field: "camera_brand_name"
                value: "Octos"
                op: "=="
              }
            ]
          }) {
            data {
              id
              name
            }
        }}
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{"list" => %{"data" => [%{"id" => user2_id, "name" => "Tony Stark"}]}}
             } == response
    end

    test "should return an empty data list if an user is not found by camera's brand name", %{
      conn: conn
    } do
      %{id: _user_id} = insert(:user)
      %{id: user2_id} = insert(:user, %{email: "another_email@octos.ai", name: "Tony Stark"})

      insert(:camera, %{user_id: user2_id, brand_name: "Octos"})

      query = """
        {
          list(params: {
            pageSize: 10
            page: 1
            filters: [
              {
                field: "camera_brand_name"
                value: "Camera test"
                op: "=="
              }
            ]
          }) {
            data {
              id
              name
            }
        }}
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{"list" => %{"data" => []}}
             } == response
    end

    test "should return the :active cameras of an user", %{conn: conn} do
      %{id: user_id} = insert(:user)
      insert(:camera, %{user_id: user_id, status: :inactive})
      insert(:camera, %{user_id: user_id})

      query = """
        {
          list(params: {
            pageSize: 10
            page: 1
          }) {
            data {
              id
              name
              cameras {
                status
              }
            }
        }}
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "list" => %{
                   "data" => [
                     %{
                       "cameras" => [%{"status" => "ACTIVE"}],
                       "id" => user_id,
                       "name" => "John Doe"
                     }
                   ]
                 }
               }
             } == response
    end
  end

  describe "query: notify users" do
    test "Should return an :ok if the users are notified", %{conn: conn} do
      %{id: user_id} = insert(:user)
      %{id: user2_id} = insert(:user, %{email: "another_email@octos.ai", name: "Tony Stark"})

      insert(:camera, %{user_id: user_id, brand_name: "Hikvision"})
      insert(:camera, %{user_id: user2_id, brand_name: "Octos"})

      query = """
        {
          notify
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{"data" => %{"notify" => "Enqueued task"}} == response
    end
  end
end
