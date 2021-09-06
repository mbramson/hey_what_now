defmodule HeyWhatNow.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add(:space_id, references(:spaces, on_delete: :nilify_all))
      add(:text, :string, size: 10_000)

      timestamps(type: :utc_datetime)
    end

    create index(:questions, [:space_id])
  end
end
