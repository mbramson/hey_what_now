defmodule HeyWhatNow.Spaces.Space do
  @moduledoc """
  Ecto schema and changeset for a Space.

  A space represents a session where users can ask questions, provider answers,
  and upvote.
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias __MODULE__

  alias HeyWhatNow.Accounts.User
  alias HeyWhatNow.AnonymousSessions.AnonymousSession
  alias HeyWhatNow.Questions.Question

  schema "spaces" do
    field(:name, :string)
    field(:key, :string)

    field(:started_at, :utc_datetime)
    field(:ended_at, :utc_datetime)

    belongs_to(:owner, User)
    belongs_to(:anonymous_owner, AnonymousSession, type: :binary_id)

    has_many(:questions, Question)

    timestamps(type: :utc_datetime)
  end

  @fields ~w(name key started_at ended_at owner_id anonymous_owner_id)a
  @required_fields ~w(key)a

  def changeset(%Space{} = space, attrs) do
    space
    |> cast(attrs, @fields)
    |> generate_name_if_missing
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

  defp generate_name_if_missing(changeset) do
    if get_field(changeset, :name) do
      changeset
    else
      default_name = "Untitled Space"
      put_change(changeset, :name, default_name)
    end
  end
end
