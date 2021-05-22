# ═════════════════════════════
# SOCKET DE ACCESO RESTRINGIDO
# ═════════════════════════════

defmodule HsocketsWeb.AuthSocket do

  use Phoenix.Socket
  require Logger

  # Apuntamos el tópico "user:*" al canal Autchannel
  channel "user:*", HsocketsWeb.AuthChannel

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

  # esta función es la que le asigna un id al SOCKET para luego poder manipularlo
  # al socket le estamos poniendo el mismo id del usuario
  def id(%{assigns: %{user_id: user_id}}) do
    "auth_socket:#{user_id}"
  end

  defp verify(socket, token) do
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
