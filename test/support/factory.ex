defmodule HeyWhatNow.Factory do
  use ExMachina.Ecto, repo: HeyWhatNow.Repo

  def user_factory do
    %HeyWhatNow.Accounts.User{
      email: sequence(:email, &"email_#{&1}@example.com"),
      hashed_password: "password_hash"
    }
  end

  def activity_factory do
    %HeyWhatNow.Activities.Activity{
      name: sequence(:activity_name, &"activity_name_#{&1}"),
      key: sequence(:activity_key, &"activity_key_#{&1}"),
      owner: build(:user)
    }
  end
end
