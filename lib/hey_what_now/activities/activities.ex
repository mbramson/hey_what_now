defmodule HeyWhatNow.Activities do
  @moduledoc """
  Contains functions for working with activities.

  An activity is created by users and relates to all actions taken during that
  activity session, including questions asked, upvoting of questions, etc.
  """

  alias HeyWhatNow.Activities.Activity
  alias HeyWhatNow.Repo

  def create_activity(params) do
    %Activity{}
    |> Activity.changeset(params)
    |> Repo.insert
  end

end
