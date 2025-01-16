defmodule Api.Providers.Mail.Behaviour do
  @moduledoc """
    Behaviour to mail provider
  """

  @callback send_email(String.t()) :: {:ok, %Bamboo.Email{}} | {:error, String.t()}
end
