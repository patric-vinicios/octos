defmodule Api.Helpers.GenerateEmailBehaviour do
  @moduledoc """
    Behaviour used to generate an email
  """
  @callback call(String.t(), String.t()) :: {:ok, String.t()}
end
