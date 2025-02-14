defmodule EggTimer.Repo do
  use Ecto.Repo,
    otp_app: :egg_timer,
    adapter: Ecto.Adapters.Postgres
end
