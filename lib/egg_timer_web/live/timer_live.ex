defmodule EggTimerWeb.TimerLive do
  use EggTimerWeb, :live_view
  alias EggTimer.Preset
  alias EggTimerWeb.Timer

  def mount(_params, _session, socket) do
    socket =
      socket
      # actual timer value display
      |> assign(:time, "0")
      # if available timers are shown
      |> assign(:timers_visible, true)
      # if timer is paused
      |> assign(:timer_pause, false)
      # name of timer
      |> assign(:title, "")
      # description of timer
      |> assign(:description, "")
      # if custom timer value is valid
      |> assign(:valid_custom, true)
      # if timer is closed (back/cancel)
      |> assign(:timer_closed, false)

    {:ok, socket}
  end

  # Triggered when start button is pressed. Starts the timer.

  # ## Parameters

  #   - time: Current time on the timer.
  #   - title: Name of the timer.
  #   - description: Description of the timer.
  #
  def handle_event(
        "start",
        %{"time" => time, "title" => title, "description" => description},
        socket
      ) do
    if connected?(socket) do
      # Start the timer
      Process.send_after(self(), :tick, 1000)
    end

    socket =
      socket
      |> assign(:time, Timer.get_init_time(time))
      |> assign(:timers_visible, false)
      |> assign(:timer_pause, false)
      |> assign(:timer_closed, false)
      |> assign(:title, title)
      |> assign(:description, description)

    {:noreply, socket}
  end

  # Triggered when there is change on the input field for the custom timer.
  # Used to check if the current input value is a valid timer value.

  # ## Parameters

  #   - custom_time: Current value of the input field for the custom timer
  #
  def handle_event("validate_custom", %{"time" => custom_time}, socket) do
    is_valid = Timer.is_valid?(custom_time)

    socket = assign(socket, :valid_custom, is_valid)

    {:noreply, socket}
  end

  # Triggered when back button or close button is clicked.
  # Shows the available timers again.
  #
  def handle_event("close", _, socket) do
    socket =
      socket
      |> assign(:time, "0")
      |> assign(:timers_visible, true)
      |> assign(:timer_pause, true)
      |> assign(:timer_closed, true)

    {:noreply, socket}
  end

  # Triggered when pause button is clicked.
  # Freezes the current time on the timer.
  #
  def handle_event("pause", _, socket) do
    socket = assign(socket, timer_pause: true)

    {:noreply, socket}
  end

  # Triggered when resume button is clicked.
  # Unfreezes the current time on the timer and continues countdown.
  #
  def handle_event("resume", _, socket) do
    socket = assign(socket, timer_pause: false)

    {:noreply, socket}
  end

  # Handles tick event even when timer is paused.
  # Unfreezes the current time on the timer and continues countdown.
  #
  def handle_info(:tick, socket)
      when socket.assigns.timer_pause do
    # Continuously run self while doing nothing when paused.
    # Note #1: When timer is resumed, it goes back to main tick event.
    # Note #2: Timer is also paused when timer is closed, so this will loop infinitely.
    #   Stop looping self when timer is closed.
    if socket.assigns.timer_closed == false do
      Process.send_after(self(), :tick, 0)
    end

    {:noreply, socket}
  end

  # Handles tick event that count down the timer every second.
  #
  def handle_info(:tick, socket) do
    new_time = Timer.countdown(socket.assigns.time)

    # If timer display is already done, no need to tick again
    if new_time != Timer.done() do
      Process.send_after(self(), :tick, 1000)
    end

    socket = assign(socket, time: new_time)
    {:noreply, socket}
  end
end
