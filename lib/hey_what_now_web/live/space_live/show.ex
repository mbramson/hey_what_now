defmodule HeyWhatNowWeb.SpaceLive.Show do
  use HeyWhatNowWeb, :live_view

  alias HeyWhatNow.Spaces
  alias HeyWhatNow.Questions
  alias HeyWhatNow.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:space, get_space(id))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp page_title(:show), do: "Show space"
  defp page_title(:new_question), do: "Ask question"

  defp get_space(id) do
    {:ok, space} = Spaces.get_space_with_assocs(id)
    space
  end

  defp apply_action(socket, :new_question, _params) do
    socket
    |> assign(:question, %Question{})
  end

  defp apply_action(socket, :edit_question, %{"question_id" => question_id}) do
    socket
    |> assign(:question, Questions.get_question!(question_id))
  end

  defp apply_action(socket, :show, _params) do
    socket
  end
end
