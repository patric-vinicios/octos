defmodule ApiWeb.Graphql.Schema.Types.Flop do
  @moduledoc false
  use Absinthe.Schema.Notation

  @desc """
  Logical Flop Representation
  """
  input_object :flop_params do
    field :order_by, list_of(:string),
      description: "Reeives a list of fields based on the type to order. Ex: ['name', 'status']"

    field :order_directions, list_of(:string),
      description:
        "Receives a list of directions based on the type to order. Ex: ['asc', 'desc'] or vice versa"

    field :page, non_null(:integer), description: "The page number"
    field :page_size, non_null(:integer), description: "The number of data per page"

    field :filters, list_of(:flop_filters),
      description: "Receives a list of JSON objects containing the filtering values"
  end

  input_object :flop_filters do
    field :value, non_null(:string), description: "The value for the `field` param"
    field :op, non_null(:string), description: "The operation type to filter for"
    field :field, non_null(:string), description: "The field name to filter. Ex: ['name']"
  end
end
