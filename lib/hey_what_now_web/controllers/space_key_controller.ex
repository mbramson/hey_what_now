defmodule HeyWhatNowWeb.SpaceKeyController do
  @moduledoc """
  Looks up a space by its key and redirects to it.
  """

  use HeyWhatNowWeb, :controller

  alias HeyWhatNow.Spaces

  action_fallback(HeyWhatNowWeb.GlobalFallbackController)

  def show(conn, %{"form" => %{"key" => key}}) do
    common_show_for_key(conn, key)
  end

  def show(conn, %{"key" => key}) do
    common_show_for_key(conn, key)
  end

  def common_show_for_key(conn, key) do
    with {:ok, space} <- Spaces.get_space_by_key(key) do
      redirect(conn, to: Routes.space_show_path(conn, :show, space))
    end
  end
end
