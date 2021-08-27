defmodule HeyWhatNow.Repo do
  use Ecto.Repo,
    otp_app: :hey_what_now,
    adapter: Ecto.Adapters.Postgres
end
