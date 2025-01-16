defmodule Api.Providers.Mail.Client do
  @moduledoc """
    Client that provides functions defined in the mailer main file
  """
  @behaviour Api.Providers.Mail.Behaviour

  def send_email(recipient) do
    mailer_api().send_email(recipient)
  end

  defp mailer_api, do: Application.get_env(:api, :mailer_api)
end
