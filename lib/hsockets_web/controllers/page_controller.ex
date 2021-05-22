defmodule HsocketsWeb.PageController do
  use HsocketsWeb, :controller

  def index(conn, _params) do

    fake_user_id = :rand.uniform(100)

    conn
    |> assign(:auth_token, generate_auth_token(conn, fake_user_id))
    |> assign(:user_id, fake_user_id)
    |> render("index.html")

  end

  defp generate_auth_token(conn, user_id) do
    Phoenix.Token.sign(conn, "saltidentifier", user_id)
  end

end
