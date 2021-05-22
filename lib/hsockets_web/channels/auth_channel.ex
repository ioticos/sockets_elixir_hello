defmodule HsocketsWeb.AuthChannel do

  use Phoenix.Channel
  require Logger


  def join("user:" <> req_user_id, _payload, socket = %{assigns: %{user_id: user_id}}) do
    if req_user_id == to_string(user_id) do
      {:ok, socket}
    else
      Logger.error("#{__MODULE__} failed #{req_user_id} != #{user_id}")
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("ping:" <> frase, payload, socket) do
    IO.inspect(socket)
    IO.inspect(payload)

    Process.send_after(self(), "salida", 1_000)

    {:reply, {:ok, %{respuesta: "pong"}}, socket}
  end

  def handle_info("salida", socket) do
    push(socket, "salida", %{data: socket.assigns.user_id})
    Process.send_after(self(), "salida", 1_000)
    {:noreply, socket}
  end

end
