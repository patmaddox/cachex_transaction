import Config

config :cachex_transaction, ecto_repos: [CachexTransaction.Repo]

config :cachex_transaction, CachexTransaction.Repo,
  database: "cachex_transaction",
  username: "postgres",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox
