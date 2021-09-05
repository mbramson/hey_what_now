defmodule HeyWhatNowWeb.SpaceController do
  @moduledoc """
  Allows for the creation of Spaces.

  A space contains a number of user questions, answers, upvotes, etc.
  """

  use HeyWhatNowWeb, :controller

  alias HeyWhatNow.Spaces

  def create(conn, params) do
    user = conn.assigns.current_user
    params = add_current_user_to_params_as_owner(params, user)

    with {:ok, space} <- Spaces.create_space(params) do
      conn
      |> put_flash(:info, "Created space with key: #{space.key}")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  defp add_current_user_to_params_as_owner(params, nil) do
    Map.put(params, "owner_id", nil)
  end

  defp add_current_user_to_params_as_owner(params, user) do
    Map.put(params, "owner_id", user.id)
  end
end
