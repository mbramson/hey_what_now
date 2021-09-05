defmodule HeyWhatNow.Spaces do
  @moduledoc """
  Contains functions for working with spaces.

  A space is created by users and relates to all actions taken during that
  space session, including questions asked, upvoting of questions, etc.
  """

  import Ecto.Query, warn: false
  alias HeyWhatNow.Repo

  alias HeyWhatNow.Spaces.Space

  def get_space_with_assocs(space_id) do
    query =
      from space in Space,
        where: space.id == ^space_id

    case Repo.one(query) do
      %Space{} = space ->
        {:ok, space}

      nil ->
        {:error, {:not_found, :space}}
    end
  end

  def create_space(params) do
    %Space{}
    |> Space.changeset(params)
    |> Repo.insert()
  end
end
