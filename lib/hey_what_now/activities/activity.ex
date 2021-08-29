defmodule HeyWhatNow.Activities.Activity do
  @moduledoc """
  Ecto schema and changeset for Activity
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias __MODULE__
  alias HeyWhatNow.Accounts.User

  schema "activities" do
    field(:name, :string)
    field(:key, :string)

    field(:started_at, :utc_datetime)
    field(:ended_at, :utc_datetime)

    belongs_to(:owner, User)

    timestamps(type: :utc_datetime)
  end

  @fields ~w(name key started_at ended_at owner_id)a
  @required_fields ~w(name key)a

  def changeset(%Activity{} = activity, attrs) do
    activity
    |> cast(attrs, @fields)
    |> generate_key_if_missing
    |> validate_required(@required_fields)
    |> EctoSanitizer.sanitize_all_strings()
  end

  defp generate_key_if_missing(changeset) do
    if get_field(changeset, :key) do
      changeset
    else
      generated_key =
        "#{Dictionary.random_word()}_#{Dictionary.random_word()}_#{Dictionary.random_word()}"
        |> String.downcase()
      put_change(changeset, :key, generated_key)
    end
  end
end
