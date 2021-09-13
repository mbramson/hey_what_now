defmodule HeyWhatNow.AnonymousSessions.AnonymousSession do
  @moduledoc """
  Ecto schema and changeset for AnonymousSession.

  Anonymous sessions represent a user's session before they create an account.
  This exists so that even without a registered account, users can own spaces,
  questions, upvotes, etc.
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "anonymous_sessions" do
    timestamps(type: :utc_datetime_usec)
  end

  @fields ~w()a
  @required_fields ~w()a

  def changeset(%AnonymousSession{} = anonymous_session, attrs) do
    anonymous_session
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> EctoSanitizer.sanitize_all_strings()
  end
end
