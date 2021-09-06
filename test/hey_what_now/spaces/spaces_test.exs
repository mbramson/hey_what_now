defmodule HeyWhatNow.SpacesTest do
  use HeyWhatNow.DataCase, async: true

  alias HeyWhatNow.Spaces
  alias HeyWhatNow.Factory

  describe "get_space_with_assocs/1" do
    test "returns a space" do
      space = Factory.insert(:space)
      assert {:ok, returned_space} = Spaces.get_space_with_assocs(space.id)
      assert returned_space.id == space.id

      assert Ecto.assoc_loaded?(returned_space.questions)
      assert returned_space.questions == []
    end

    test "returns a space with questions associated with the space" do
      space = Factory.insert(:space)
      question = Factory.insert(:question, space: space)
      _other_question = Factory.insert(:question)

      assert {:ok, returned_space} = Spaces.get_space_with_assocs(space.id)
      assert returned_space.id == space.id

      assert Ecto.assoc_loaded?(returned_space.questions)
      assert [returned_question] = returned_space.questions
      assert returned_question.id == question.id
    end

    test "returns an error if space does not exist" do
      assert {:error, {:not_found, :space}} = Spaces.get_space_with_assocs(-1)
    end
  end

  describe "get_space_by_key/1" do
    test "returns space associated with the key" do
      [space, _other_space] = Factory.insert_pair(:space)
      assert {:ok, returned_space} = Spaces.get_space_by_key(space.key)
      assert returned_space.id == space.id
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
