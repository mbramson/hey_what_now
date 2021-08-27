defmodule HeyWhatNow.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add(:name, :string, null: false)
      add(:key, :string, null: false)

      add(:started_at, :utc_datetime)
      add(:ended_at, :utc_datetime)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:activities, [:key])
  end
end
