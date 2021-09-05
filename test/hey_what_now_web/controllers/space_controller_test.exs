defmodule HeyWhatNowWeb.SpaceControllerTest do
  use HeyWhatNowWeb.ConnCase, async: true

  alias HeyWhatNow.Factory
  alias HeyWhatNow.Repo
  alias HeyWhatNow.Spaces.Space

  describe "create/2" do
    test "creates a space and redirects", %{conn: conn} do
      conn = get(conn, Routes.space_path(conn, :create))
      assert get_flash(conn, :info) =~ "Created space with key"
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      assert [created_space] = Repo.all(Space)
      assert created_space.name == "Untitled Space"
      refute created_space.key == nil
      assert created_space.owner_id == nil
    end

    test "does not allow specifying an arbitrary owner", %{conn: conn} do
      user = Factory.insert(:user)
      conn = get(conn, Routes.space_path(conn, :create, owner_id: user.id))
      assert get_flash(conn, :info) =~ "Created space with key"
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      assert [created_space] = Repo.all(Space)
      assert created_space.owner_id == nil
    end

    test "allows you to specify the name of the created space in query params", %{conn: conn} do
      get(conn, Routes.space_path(conn, :create, name: "passed_in_name"))
      assert [created_space] = Repo.all(Space)
      assert created_space.name == "passed_in_name"
    end

    test "allows you to specify the key of the created space in query params", %{conn: conn} do
      get(conn, Routes.space_path(conn, :create, key: "passed_in_key"))
      assert [created_space] = Repo.all(Space)
      assert created_space.key == "passed_in_key"
    end
  end

  describe "create/2 when logged in" do
    setup :register_and_log_in_user

    test "if logged in, assigns the current user as owner", %{conn: conn, user: user} do
      conn = get(conn, Routes.space_path(conn, :create))

      assert get_flash(conn, :info) =~ "Created space with key"
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      assert [created_space] = Repo.all(Space)
      assert created_space.name == "Untitled Space"
      refute created_space.key == nil
      assert created_space.owner_id == user.id
    end
  end
end
