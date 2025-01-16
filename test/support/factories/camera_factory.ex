defmodule Api.Factories.CameraFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Api.Repo

  alias Api.Cameras.Camera

  defmacro __using__(_opts) do
    quote do
      def camera_params_factory do
        %{
          "brand_name" => "Camera test name",
          "status" => "active"
        }
      end

      def camera_factory do
        %Camera{
          brand_name: "Camera test name",
          status: :active
        }
      end
    end
  end
end
