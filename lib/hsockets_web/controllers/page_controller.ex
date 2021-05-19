defmodule HsocketsWeb.PageController do
  use HsocketsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
