defmodule HeyWhatNowWeb.SpaceKeyControllerTest do
  use HeyWhatNowWeb.ConnCase, async: true

  alias HeyWhatNow.Factory

  describe "show/2" do
    test "redirects to show path of space", %{conn: conn} do
      space = Factory.insert(:space)
      conn = get(conn, Routes.space_key_path(conn, :show, space.key))
      assert redirected_to(conn) == Routes.space_show_path(conn, :show, space)
    end

    test "redirects to show path from a form", %{conn: conn} do
      space = Factory.insert(:space)
      params = %{form: %{key: space.key}}
      conn = post(conn, Routes.space_key_path(conn, :show), params)
      assert redirected_to(conn) == Routes.space_show_path(conn, :show, space)
    end

    test "redirects to home page with error if space not found", %{conn: conn} do
      conn = get(conn, Routes.space_key_path(conn, :show, "bad_key"))
      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert get_flash(conn, :error) == "Space not found"
    end

    test "redirects to home page with error if space not found from a form", %{conn: conn} do
      params = %{form: %{key: "bad_key"}}
      conn = post(conn, Routes.space_key_path(conn, :show), params)
      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert get_flash(conn, :error) == "Space not found"
    end
  end
end
