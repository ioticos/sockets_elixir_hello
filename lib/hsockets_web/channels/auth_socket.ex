defmodule HsocketsWeb.AuthSocket do

  use Phoenix.Socket


  channel"ping", HsocketsWeb.PingChannel
  channel"tracked", HsocketsWeb.TrackedChannel

  require Logger

  def connect(%{"token" => token}, socket) do
    case verify(socket, token) do
      {:ok, user_id} ->
        socket = assign(socket, :user_id, user_id)
        {:ok, socket}

      {:error, err} ->
        Logger.error("#{__MODULE__} connect error #{inspect(err)}")
        :error
    end
  end

  def connect(_, _socket) do
    Logger.error("#{__MODULE__} connect error missing params")
    :error
  end

  defp verify(socket,token) do
    Phoenix.Token.verify(
      socket,
      "saltidentifier",
      token,
      max_age: 86400
    )
  end

end

# rita  -> 727981218
# compu -> 825311337
