defmodule HeyWhatNowWeb.SpaceLive.Show do
  use HeyWhatNowWeb, :live_view

  alias Phoenix.PubSub

  alias HeyWhatNow.Spaces
  alias HeyWhatNow.Questions
  alias HeyWhatNow.Questions.Question

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    PubSub.subscribe(HeyWhatNow.PubSub, "space:#{id}")
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

  @impl true
  def handle_event("mark_answered", %{"question-id" => question_id}, socket) do
    question_id = String.to_integer(question_id)

    attrs = %{is_answered: true}
    question = Enum.find(socket.assigns.space.questions, &(&1.id == question_id))
    Questions.update_question(question, attrs)

    refresh_space_for_all_users(socket)

    {:noreply, socket}
  end

  @impl true
  def handle_info(:refresh_space, socket) do
    old_space = socket.assigns.space
    new_socket = assign(socket, :space, get_space(old_space.id))
    {:noreply, new_socket}
  end

  defp refresh_space_for_all_users(socket) do
    space_id = socket.assigns.space.id
    PubSub.broadcast(HeyWhatNow.PubSub, "space:#{space_id}", :refresh_space)
  end
end
