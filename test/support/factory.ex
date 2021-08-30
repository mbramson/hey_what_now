defmodule HeyWhatNow.Factory do
  use ExMachina.Ecto, repo: HeyWhatNow.Repo

  def user_factory do
    %HeyWhatNow.Accounts.User{
      email: sequence(:email, &"email_#{&1}@example.com"),
      hashed_password: "password_hash"
    }
  end

  def space_factory do
    %HeyWhatNow.Spaces.Space{
      name: sequence(:space_name, &"space_name_#{&1}"),
      key: sequence(:space_key, &"space_key_#{&1}"),
      owner: build(:user)
    }
  end
end