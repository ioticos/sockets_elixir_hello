defmodule HsocketsWeb.UserTracker do
  def track(%{channel_pid: pid, topic: topic, assigns: %{user_id: user_id}}) do
    metadata = %{
      online_at: DateTime.utc_now(),
      user_id: user_id
    }

    Phoenix.Tracker.track(__MODULE__, pid, topic, user_id, metadata)
  end

  def list(topic \\ "tracked") do
    Phoenix.Tracker.list(__MODULE__, topic)
  end
end
