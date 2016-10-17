use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :slowmonster, Slowmonster.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :slowmonster, Slowmonster.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "b4o6L6ZSbUBP",
  database: "slowmonster_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# faster encryption in test mode
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
