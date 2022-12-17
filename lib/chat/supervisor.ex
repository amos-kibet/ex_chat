defmodule Chat.Supervisor do
  alias Task.Supervised
  use Supervisor

  def start_link do
    # We are now registering our supervisor with a name
    # so we can reference it in the `start_room/1` function
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def start_room(name) do
    Supervisor.start_child(:chat_supervisor, [name])
  end

  def init(_) do
    children = [
      worker(Chat.Server, [])
    ]

    # We also changed the `strategy` to `simple_one_for_one`.
    # With this strategy, we define just a "template" for a child,
    # no process is started during the Supervisor initialization, just
    # when we call `start_child/2`
    supervise(children, strategy: :simple_one_for_one)
  end
end
