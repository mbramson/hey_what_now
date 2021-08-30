defmodule HeyWhatNowWeb.SpaceController do
  @moduledoc """
  Allows for the creation of Spaces.

  A space contains a number of user questions, answers, upvotes, etc.
  """

  use HeyWhatNowWeb, :controller

  alias HeyWhatNow.Spaces

  def create(conn, params) do
    with {:ok, space} <- Spaces.create_space(params) do
      conn
      |> put_flash(:info, "Created space with key: #{space.key}")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
