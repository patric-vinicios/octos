defmodule Api.Providers.Mail.BambooTest do
  use Api.DataCase, async: true

  alias Api.Providers.Mail.Client

  @moduletag :unit

  describe "bamboo provider" do
    test "send email" do
      email = "tony_stark@gmail.com"

      response = Client.send_email(email)

      assert {:ok,
              %Bamboo.Email{
                from: {nil, "naoresponda@octos.ai"},
                to: [nil: "tony_stark@gmail.com"],
                cc: [],
                bcc: [],
                subject: "Subject",
                html_body: "<strong>Do you know the Avengers initiative?</strong>",
                text_body: nil,
                headers: %{"Reply-To" => "octos_admin@octos.ai"},
                attachments: [],
                assigns: %{},
                private: %{},
                blocked: false
              }} = response
    end
  end
end
