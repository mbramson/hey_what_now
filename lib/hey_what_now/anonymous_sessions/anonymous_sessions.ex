defmodule HeyWhatNow.AnonymousSessions do
  @moduledoc """
  Contains functions for working with anonymous sessions.

  Anonymous sessions represent a user's session before they create an account.
  This exists so that even without a registered account, users can own spaces,
  questions, upvotes, etc.
  """

  alias HeyWhatNow.AnonymousSessions.AnonymousSession
  alias HeyWhatNow.Repo

  def create_anonymous_session(attrs \\ %{}) do
    %AnonymousSession{}
    |> AnonymousSession.changeset(attrs)
    |> Repo.insert()
  end

  def get_anonymous_session(id) do
    Repo.get(AnonymousSession, id)
  end
end
