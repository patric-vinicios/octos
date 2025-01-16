defmodule ApiWeb.Graphql.Schema do
  @moduledoc false
  use Absinthe.Schema

  import_types(Absinthe.Plug.Types)

  # Custom types
  import_types(ApiWeb.Graphql.Schema.Types.Custom.{
    UUID4
  })

  # Types
  import_types(ApiWeb.Graphql.Schema.Types.{
    Camera,
    Flop,
    User
  })

  # Root
  import_types(ApiWeb.Graphql.Schema.Types.Root.{
    User
  })

  import_types(Absinthe.{
    Plug.Types,
    Type.Custom
  })

  query do
    import_fields(:root_query_user)
  end
end
