defmodule HeyWhatNowWeb.PageController do
  use HeyWhatNowWeb, :controller

  def index(conn, params) do
    changeset = form_changeset(params)
    render(conn, "index.html", changeset: changeset)
  end

  defmodule Form do
    @moduledoc false
    defstruct [:activity_key]
  end

  @fields ~w(activity_key)a

  defp form_changeset(attrs) do
    struct = %Form{}
    types = %{activity_key: :string}

    {struct, types}
    |> Ecto.Changeset.cast(attrs, @fields)
    |> Ecto.Changeset.validate_required(@fields)
  end
end
