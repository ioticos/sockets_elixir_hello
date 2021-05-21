defmodule HsocketsWeb.UserSocket do

  use Phoenix.Socket
  channel "ping:*", HsocketsWeb.PingChannel
  #channel "tracked", HsocketsWeb.TrackedChannel

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end


  @impl true
  def id(_socket), do: nil

end
