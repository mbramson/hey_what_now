defmodule HeyWhatNowWeb.SpaceLiveTest do
  use HeyWhatNowWeb.ConnCase

  import Phoenix.LiveViewTest

  alias HeyWhatNow.Factory

  defp create_space(_) do
    space = Factory.insert(:space)
    %{space: space}
  end

  describe "Show" do
    setup [:create_space]

    test "displays space", %{conn: conn, space: space} do
      {:ok, _show_live, html} = live(conn, Routes.space_show_path(conn, :show, space))

      assert html =~ space.name
      assert html =~ space.key
    end
  end
end
