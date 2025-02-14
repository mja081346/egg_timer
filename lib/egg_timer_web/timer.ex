defmodule EggTimerWeb.Timer do
  def done(), do: "Done!"

  @doc """
  Checks if input to custom timer is a valid time
  It is valid if the following conditions are all met:
    - Must be in HH:MM:SS format
    - Cannot be 00:00:00
    - Must be actual clock time

  ## Parameters

    - timer_value: Custom timer input value

  ## Examples

      iex> is_valid?("000")
      false

      iex> is_valid?("00:01:46")
      true

  """
  def is_valid?(timer_value) do
    String.match?(timer_value, ~r/^\d{2}:\d{2}:\d{2}$/) and
      String.equivalent?(timer_value, "00:00:00") == false and
      is_actual_clock_time?(timer_value)
  end

  # Checks if actual clock time.
  # The following conditions must be all met:
  #   - Hour must be 00~23
  #   - Minute must be 00~59
  #   - Seconds must be 00~59

  # ## Parameters

  #   - time_text: Time string in HH:MM:SS

  # ## Examples

  #     iex> is_actual_clock_time?("00:10:59")
  #     true

  #     iex> is_actual_clock_time?("00:70:46")
  #     false
  #
  defp is_actual_clock_time?(time_text) do
    hh_mm_ss = timer_value_to_time_list(time_text)

    case length(hh_mm_ss) do
      3 ->
        # Hour must be 00~23
        # Minute must be 00~59
        # Seconds must be 00~59
        if Enum.at(hh_mm_ss, 0) < 24 and
             Enum.at(hh_mm_ss, 1) < 60 and
             Enum.at(hh_mm_ss, 2) < 60 do
          true
        else
          # Else it is invalid
          false
        end

      _ ->
        raise ArgumentError, message: "the argument value is invalid"
    end
  end

  # Get the initial time display on the timer

  # ## Parameters

  #   - time_text: Time string in HH:MM:SS
  #
  def get_init_time(time_text) do
    time = timer_value_to_time(time_text)
    time_to_timer_display(time)
  end

  # Get the next time display on the timer

  # ## Parameters

  #   - timer_value: Time string in HH:MM:SS
  #
  def countdown(timer_value) do
    # Make sure it does not do anything if it is already done
    if timer_value == done() do
      timer_value
    else
      # If not, count down the timer by a second
      time = timer_value_to_time(timer_value)
      next_time = Time.add(time, -1, :second)
      time_to_timer_display(next_time)
    end
  end

  # Convert timer value to a Time struct

  # ## Parameters

  #   - time_text: Time string in HH:MM:SS
  #
  defp timer_value_to_time(time_text) do
    hh_mm_ss_list = timer_value_to_time_list(time_text)
    time_list_to_time(hh_mm_ss_list)
  end

  # Convert timer value to a list containing the hours, minutes and seconds in that order

  # ## Parameters

  #   - time_text: Time string in HH:MM:SS
  #
  defp timer_value_to_time_list(time_text) do
    hh_mm_ss =
      time_text
      |> String.split(":")
      |> Enum.map(&String.to_integer/1)

    hh_mm_ss
  end

  # Convert a list containing the hours, minutes and seconds in that order to a Time struct

  # ## Parameters

  #   - hh_mm_ss: list containing the hours, minutes and seconds in that order
  #
  defp time_list_to_time(hh_mm_ss) do
    IO.puts(hh_mm_ss)

    case length(hh_mm_ss) do
      3 ->
        Time.new!(Enum.at(hh_mm_ss, 0), Enum.at(hh_mm_ss, 1), Enum.at(hh_mm_ss, 2))

      2 ->
        Time.new!(0, Enum.at(hh_mm_ss, 0), Enum.at(hh_mm_ss, 1))

      _ ->
        Time.new!(0, 0, Enum.at(hh_mm_ss, 0))
    end
  end

  # Convert a Time struct to timer display value.
  # Remove the leading zeros of the time value

  # ## Parameters

  #   - time: a Time struct
  #
  defp time_to_timer_display(time) do
    time_string = Time.to_string(time)

    cond do
      # 00:00:00 (Timer finished)
      String.match?(time_string, ~r/00:00:00/) ->
        done()

      # Seconds only
      String.match?(time_string, ~r/00:00:0/) ->
        String.trim_leading(time_string, "00:00:0")

      String.match?(time_string, ~r/00:00/) ->
        String.trim_leading(time_string, "00:00:")

      # Minutes, Seconds
      String.match?(time_string, ~r/00:0/) ->
        String.trim_leading(time_string, "00:0")

      String.match?(time_string, ~r/00:/) ->
        String.trim_leading(time_string, "00:")

      # Hours, Minutes, Seconds
      String.match?(time_string, ~r/0/) ->
        String.trim_leading(time_string, "0:")

      true ->
        time_string
    end
  end
end
