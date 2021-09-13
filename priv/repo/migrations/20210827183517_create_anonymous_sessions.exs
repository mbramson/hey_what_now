defmodule HeyWhatNow.Repo.Migrations.CreateAnonymousSessions do
  use Ecto.Migration

  def change do
    create table(:anonymous_sessions, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      timestamps(type: :utc_datetime_usec)
    end
  end
end
