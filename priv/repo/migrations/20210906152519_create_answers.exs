defmodule HeyWhatNow.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :text, :string

      timestamps()
    end
  end
end
