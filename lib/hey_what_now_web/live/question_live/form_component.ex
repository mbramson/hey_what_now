defmodule HeyWhatNowWeb.QuestionLive.FormComponent do
  use HeyWhatNowWeb, :live_component

  alias HeyWhatNow.Questions
  alias Phoenix.PubSub

  @impl true
  def update(%{question: question, space_id: space_id} = assigns, socket) do
    changeset = Questions.change_question(question, %{space_id: space_id})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"question" => question_params}, socket) do
    changeset =
      socket.assigns.question
      |> Questions.change_question(question_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"question" => question_params}, socket) do
    save_question(socket, socket.assigns.action, question_params)
  end

  defp save_question(socket, :edit_question, question_params) do
    case Questions.update_question(socket.assigns.question, question_params) do
      {:ok, _question} ->
        refresh_space_for_all_users(socket)

        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_question(socket, :new_question, question_params) do
    case Questions.create_question(question_params) do
      {:ok, _question} ->
        refresh_space_for_all_users(socket)

        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp refresh_space_for_all_users(socket) do
    space_id = socket.assigns.space_id
    PubSub.broadcast(HeyWhatNow.PubSub, "space:#{space_id}", :refresh_space)
  end
end
