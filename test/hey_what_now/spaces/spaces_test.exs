defmodule HeyWhatNow.SpacesTest do
  use HeyWhatNow.DataCase, async: true

	alias HeyWhatNow.Spaces
  alias HeyWhatNow.Factory

  describe "create_space/1" do
    test "creates an space " do
      user = Factory.insert(:user)
      params = Factory.string_params_for(:space, owner: user)

      assert {:ok, created_space} = Spaces.create_space(params)
      assert created_space.owner_id == user.id
      assert created_space.name == params["name"]
      assert created_space.key == params["key"]
    end

    test "assigns a key if none is provided" do
      params = Factory.string_params_for(:space, key: nil)
      assert {:ok, created_space} = Spaces.create_space(params)
      refute created_space.key == nil
    end

    test "returns an error if params are invalid" do
      params = Factory.string_params_for(:space, name: 123)
      assert {:error, changeset} = Spaces.create_space(params)
      assert "is invalid" in errors_on(changeset)[:name]
    end
  end
end
