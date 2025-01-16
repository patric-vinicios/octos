defmodule Api.Flop do
  @moduledoc """
    Module to handle Flop operations
  """

  def call(_query, %{page: page}, _entity) when page <= 0,
    do: {:error, "`page` param must be higher than 0"}

  def call(_query, %{page_size: page_size}, _entity) when page_size <= 0,
    do: {:error, "`page_size` param must be higher than 0"}

  def call(query, params, entity) do
    query
    |> Flop.validate_and_run(params, for: entity)
    |> handle_flop_data()
  end

  defp handle_flop_data({:ok, {result, %Flop.Meta{} = meta}}) do
    {:ok,
     %{
       data: result,
       current_page: meta.current_page,
       next_page: meta.next_page,
       previous_page: meta.previous_page,
       total_count: meta.total_count,
       total_pages: meta.total_pages,
       has_next_page: meta.has_next_page?,
       has_previous_page: meta.has_previous_page?,
       errors: meta.errors,
       page: meta.flop.page,
       page_size: meta.flop.page_size
     }}
  end

  defp handle_flop_data({:error, %Flop.Meta{} = meta}) do
    {:error,
     %{
       data: [],
       current_page: meta.current_page,
       next_page: meta.next_page,
       previous_page: meta.previous_page,
       total_count: meta.total_count,
       total_pages: meta.total_pages,
       has_next_page: meta.has_next_page?,
       has_previous_page: meta.has_previous_page?,
       errors: meta.errors,
       page: meta.flop.page,
       page_size: meta.flop.page_size
     }}
  end
end
