defmodule HeyWhatNow.SpacesTest do
  use HeyWhatNow.DataCase, async: true

  alias HeyWhatNow.Spaces
  alias HeyWhatNow.Factory

  describe "get_space_with_assocs/1" do
    test "returns a space" do
      space = Factory.insert(:space)
      assert {:ok, returned_space} = Spaces.get_space_with_assocs(space.id)
      assert returned_space.id == space.id
    end

    test "returns an error if space does not exist" do
      assert {:error, {:not_found, :space}} = Spaces.get_space_with_assocs(-1)
    end
  end

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
