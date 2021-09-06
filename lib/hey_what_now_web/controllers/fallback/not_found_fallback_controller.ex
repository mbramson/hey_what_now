defmodule HeyWhatNowWeb.NotFoundFallbackController do
  @moduledoc """
  Fallback controller for all instances of not being able to find a given resource.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use HeyWhatNowWeb, :controller

  def call(conn, {:error, {:not_found, :space}}) do
    conn
    |> put_flash(:error, "Space not found")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
