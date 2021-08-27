defmodule HeyWhatNowWeb.PageController do
  use HeyWhatNowWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
