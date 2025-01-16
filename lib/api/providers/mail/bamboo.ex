defmodule Api.Providers.Mail.Bamboo do
  @moduledoc """
    Contains the specific implementation of an email provider.
  """
  @behaviour Api.Providers.Mail.Behaviour

  use Bamboo.Mailer, otp_app: :api

  def send_email(recipient) do
    recipient
    |> build_email_template()
    |> deliver_now()
  end

  defp build_email_template(recipient) do
    Bamboo.Email.new_email()
    |> email_from("naoresponda@octos.ai")
    |> email_to(recipient)
    |> email_subject()
    |> email_header()
    |> email_body()
  end

  defp email_from(%Bamboo.Email{} = bamboo_template, sender_email),
    do: Bamboo.Email.from(bamboo_template, sender_email)

  defp email_to(%Bamboo.Email{} = bamboo_template, recipient),
    do: Bamboo.Email.to(bamboo_template, recipient)

  defp email_subject(%Bamboo.Email{} = bamboo_template),
    do: Bamboo.Email.subject(%Bamboo.Email{} = bamboo_template, "Subject")

  defp email_header(%Bamboo.Email{} = bamboo_template),
    do: Bamboo.Email.put_header(bamboo_template, "Reply-To", "octos_admin@octos.ai")

  defp email_body(%Bamboo.Email{} = bamboo_template),
    do:
      Bamboo.Email.html_body(
        bamboo_template,
        "<strong>Do you know the Avengers initiative?</strong>"
      )
end
