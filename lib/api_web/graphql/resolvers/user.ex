defmodule ApiWeb.Graphql.Resolvers.User do
  @moduledoc false
  alias Api.Users

  def list(%{params: params}, _context), do: Users.list(params)
  def notify(_, _context), do: Users.notify()
end
