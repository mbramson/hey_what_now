defmodule HeyWhatNow.Questions.Question do
  @moduledoc """
  Ecto schema and changeset for questions that are asked during a meeting in a
  space.
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias __MODULE__

  alias HeyWhatNow.Spaces.Space

  schema "questions" do
    field(:text, :string)
    belongs_to(:space, Space)

    timestamps(type: :utc_datetime)
  end

  @fields ~w(text space_id)a
  @required_fields ~w(text)a

  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
