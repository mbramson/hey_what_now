defmodule HeyWhatNow.ActivitiesTest do
  use HeyWhatNow.DataCase

	alias HeyWhatNow.Activities
  alias HeyWhatNow.Factory

  describe "create_activity/1" do
    test "creates an activity " do
      user = Factory.insert(:user)
      params = Factory.string_params_for(:activity, owner: user)

      assert {:ok, created_activity} = Activities.create_activity(params)
      assert created_activity.owner_id == user.id
      assert created_activity.name == params["name"]
      assert created_activity.key == params["key"]
    end

    test "assigns a key if none is provided" do
      params = Factory.string_params_for(:activity, key: nil)
      assert {:ok, created_activity} = Activities.create_activity(params)
      refute created_activity.key == nil
    end

    test "returns an error if params are invalid" do
      params = Factory.string_params_for(:activity, name: 123)
      assert {:error, changeset} = Activities.create_activity(params)
      assert "is invalid" in errors_on(changeset)[:name]
    end
  end
end
