defmodule HeyWhatNow.AnswersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HeyWhatNow.Answers` context.
  """

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> HeyWhatNow.Answers.create_answer()

    answer
  end
end
