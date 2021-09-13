defmodule HeyWhatNowWeb.SpaceLive.NameChangeFormComponent do
  use HeyWhatNowWeb, :live_component

  alias HeyWhatNow.Spaces
  alias Phoenix.PubSub

  @impl true
  def update(%{space: space} = assigns, socket) do
    changeset = Spaces.change_space(space, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"space" => space_params}, socket) do
    changeset =
      socket.assigns.space
      |> Spaces.change_space(space_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"space" => space_params}, socket) do
    save_space(socket, space_params)
  end

  defp save_space(socket, space_params) do
    case Spaces.update_space(socket.assigns.space, space_params) do
      {:ok, _space} ->
        refresh_space_for_all_users(socket)

        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp refresh_space_for_all_users(socket) do
    space_id = socket.assigns.space.id
    PubSub.broadcast(HeyWhatNow.PubSub, "space:#{space_id}", :refresh_space)
  end
end
