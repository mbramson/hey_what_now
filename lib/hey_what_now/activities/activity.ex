defmodule HeyWhatNow.Activities.Activity do
  @moduledoc """
  Ecto schema and changeset for Activity
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias __MODULE__

  schema "activities" do
    field(:name, :string)
    field(:key, :string)

    field(:started_at, :utc_datetime)
    field(:ended_at, :utc_datetime)

    timestamps(type: :utc_datetime)
  end

  @fields ~w(name key started_at ended_at)a
  @required_fields ~w()a

  def changeset(%Activity{} = activity, attrs) do
    activity
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> EctoSanitizer.sanitize_all_strings()
  end
end
