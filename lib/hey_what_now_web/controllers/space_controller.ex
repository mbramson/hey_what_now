defmodule HeyWhatNowWeb.SpaceController do
  @moduledoc """
  Allows for the creation of Spaces.

  A space contains a number of user questions, answers, upvotes, etc.
  """

  use HeyWhatNowWeb, :controller

  alias HeyWhatNow.Spaces

  def create(conn, params) do
    user = conn.assigns.current_user
    anonymous_session_id = conn.assigns.anonymous_session_id

    params =
      params
      |> add_current_user_to_params_as_owner(user)
      |> add_anonymous_session_id_to_params_as_anonymous_owner(anonymous_session_id)

    with {:ok, space} <- Spaces.create_space(params) do
      conn
      |> put_flash(:info, "Created space with key: #{space.key}")
      |> redirect(to: Routes.space_show_path(conn, :show, space.id))
    end
  end

  defp add_current_user_to_params_as_owner(params, nil) do
    Map.put(params, "owner_id", nil)
  end

  defp add_current_user_to_params_as_owner(params, user) do
    Map.put(params, "owner_id", user.id)
  end

  defp add_anonymous_session_id_to_params_as_anonymous_owner(params, nil) do
    Map.put(params, "anonymous_owner_id", nil)
  end

  defp add_anonymous_session_id_to_params_as_anonymous_owner(params, anonymous_session_id) do
    Map.put(params, "anonymous_owner_id", anonymous_session_id)
  end
end
