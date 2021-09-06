defmodule HeyWhatNowWeb.GlobalFallbackController do
  @moduledoc """
  Fallback Controller that all fallback controllers should eventually fall back
  to if none of their more specific cases match.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use HeyWhatNowWeb, :controller

  alias HeyWhatNowWeb.NotFoundFallbackController

  def call(conn, {:error, {:not_found, _}} = error) do
    NotFoundFallbackController.call(conn, error)
  end

  def call(_conn, other_thing) do
    # credo:disable-for-next-line
    IO.inspect(other_thing, label: "Uncaught Fallback return")
  end
end
