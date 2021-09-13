defmodule HeyWhatNow.Factory do
  use ExMachina.Ecto, repo: HeyWhatNow.Repo

  def user_factory do
    %HeyWhatNow.Accounts.User{
      email: sequence(:email, &"email_#{&1}@example.com"),
      hashed_password: "password_hash"
    }
  end

  def anonymous_session_factory do
    %HeyWhatNow.AnonymousSessions.AnonymousSession{}
  end

  def space_factory do
    %HeyWhatNow.Spaces.Space{
      name: sequence(:space_name, &"space_name_#{&1}"),
      key: sequence(:space_key, &"space_key_#{&1}"),
      owner: build(:user)
    }
  end

  def question_factory do
    %HeyWhatNow.Questions.Question{
      space: build(:space),
      text: sequence(:question_text, &"question_text_#{&1}"),
      is_answered: random_boolean()
    }
  end

  defp random_boolean do
    Enum.random([true, false])
  end
end
