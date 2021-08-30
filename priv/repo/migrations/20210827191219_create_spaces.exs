defmodule HeyWhatNow.Repo.Migrations.CreateSpaces do
  use Ecto.Migration

  def change do
    create table(:spaces) do
      add(:name, :string, null: false)
      add(:key, :string, null: false)

      add(:owner_id, references(:users, on_delete: :nilify_all), null: true)

      add(:started_at, :utc_datetime)
      add(:ended_at, :utc_datetime)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:spaces, [:key])
    create index(:spaces, [:owner_id])
  end
end
