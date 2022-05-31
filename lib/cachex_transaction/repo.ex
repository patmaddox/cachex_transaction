defmodule CachexTransaction.Repo do
  use Ecto.Repo,
    otp_app: :cachex_transaction,
    adapter: Ecto.Adapters.Postgres
end
