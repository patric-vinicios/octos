# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

alias Api.Providers.Mail.Bamboo, as: BambooMailer

config :api,
  ecto_repos: [Api.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :api, Api.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :flop, repo: Api.Repo

config :api, Api.Providers.Mail.Bamboo, adapter: Bamboo.LocalAdapter

# Providers
# All providers should be defined below

config :api, :mailer_api, BambooMailer

config :api, Oban,
  engine: Oban.Engines.Basic,
  queues: [
    notify_hackivision_users: 50
  ],
  repo: Api.Repo

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Api.PubSub,
  live_view: [signing_salt: "rTe3jkFU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
