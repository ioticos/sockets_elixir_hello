defmodule HsocketsWeb.PingChannel do
  use Phoenix.Channel
  intercept ["request_ping"]


  # PARA LOGUEARSE A DIFERENTES TOPICOS
  # NOTESE PUEDO PASAR INFO EN EL CUERPO DEL TOPICO SEPARADO POR :
  # O BIEN PUEDO PASARLO POR EL PAYLOAD
  # MENSAJE -> ["1","1","ping:123","phx_join",{estoEs: "payload"}]
  # OJO EL PAYLOAD DEBE SER UN JSON VALIDO
  def join("ping:" <> numbers, payload, socket) do
    IO.puts("SE HA CONECTADO CLIENTE AL TOPICO WILD:")

    IO.inspect(numbers)
    IO.inspect(payload)

    if numbers == "123" do
      {:ok, socket}
    else
      {:error, %{}}
    end
  end

  # Notese como en eventos tambien puedo rescatar parte del nombre del evento
  # en caso de brundar una respuesta la misma se compone de una tupla,
  # primer parametro esun status a donde no es obligatorio el :ok puede ser cualquier cosa
  # segundo parametro es un payload, recomendado que el payload sea un mapa
  # ejemplo de respuesta {:ok, %{ping: "pong"}}

  def handle_in("ping:" <> frase, _payload, socket) do
    IO.inspect(frase)
    {:reply, {:ok, %{ping: "pong"}}, socket}
  end

  def handle_in("pong", _payload, socket) do
    IO.puts("pong recibido")
    {:reply, {:ok, %{ping: "pong"}}, socket}
  end


  #coando mando un broadcast desde cualquier parte de la plataforma esta funciòn lo recibe y lo envìa a los clientes conectados al canal
  # HsocketsWeb.Endpoint.broadcast("ping:123","request_ping",%{})
  def handle_out("request_ping", payload, socket) do
    push(socket, "send_ping", Map.put(payload, "from_node", Node.self()))
    {:noreply, socket}
  end



end
