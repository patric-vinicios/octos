defmodule ApiWeb.Graphql.Schema.Types.Root.User do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias ApiWeb.Graphql.Resolvers.User, as: UserResolver

  object :root_query_user do
    @desc """
      User List
    """
    field :list, type: :list_users do
      arg(:params, non_null(:flop_params))
      resolve(&UserResolver.list/2)
    end

    @desc """
      Notify users by email
    """
    field :notify, type: :string do
      resolve(&UserResolver.notify/2)
    end
  end
end
