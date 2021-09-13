defmodule HeyWhatNow.AnonymousSessions.AnonymousSessionPlugs do
  @moduledoc """
  Contains functions useful for interacting with anonymous sessions in the
  context of a router or controller.
  """

  import Plug.Conn

  alias HeyWhatNow.AnonymousSessions

  def add_anonymous_session_if_no_current_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      if get_session(conn, :anonymous_session_id) do
        conn
      else
        {:ok, anonymous_session} = AnonymousSessions.create_anonymous_session()

        conn
        |> put_session(:anonymous_session_id, anonymous_session.id)
        |> assign(:anonymous_session_id, anonymous_session.id)
      end
    end
  end
end
