defmodule Favorite.Repo do
  use Ecto.Repo,
    otp_app: :favorite,
    adapter: Ecto.Adapters.Postgres
end
