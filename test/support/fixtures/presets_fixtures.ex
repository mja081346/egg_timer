defmodule EggTimer.PresetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EggTimer.Presets` context.
  """

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        value: "some value"
      })
      |> EggTimer.Presets.create_timer()

    timer
  end
end
