defmodule HeyWhatNowWeb.SpaceLive.Show do
  use HeyWhatNowWeb, :live_view

  alias HeyWhatNow.Spaces

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:space, get_space(id))}
  end

  defp page_title(:show), do: "Show Space"

  defp get_space(id) do
    {:ok, space} = Spaces.get_space_with_assocs(id)
    space
  end

  @impl true
  def handle_event("ask_question", _value, socket) do
    IO.inspect("ASKED")
    {:noreply, socket}
  end
end
