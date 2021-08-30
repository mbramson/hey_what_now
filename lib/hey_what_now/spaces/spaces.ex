defmodule HeyWhatNow.Spaces do
  @moduledoc """
  Contains functions for working with spaces.

  A space is created by users and relates to all actions taken during that
  space session, including questions asked, upvoting of questions, etc.
  """

  alias HeyWhatNow.Spaces.Space
  alias HeyWhatNow.Repo

  def create_space(params) do
    %Space{}
    |> Space.changeset(params)
    |> Repo.insert
  end
end
