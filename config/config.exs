# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :api_bank,
  ecto_repos: [ApiBank.Repo]

config :api_bank_web,
  ecto_repos: [ApiBank.Repo],
  generators: [context_app: :api_bank, binary_id: true]

# Configures the endpoint
config :api_bank_web, ApiBankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zNjJDNXPauBoAaSJEFtIwXXKmhCi9Y+TmW8bet53DOlkV6X1VBlU+qS+eMPQk6QJ",
  render_errors: [view: ApiBankWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiBank.PubSub,
  live_view: [signing_salt: "C37GflOr"]

config :api_bank, ApiBank.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
