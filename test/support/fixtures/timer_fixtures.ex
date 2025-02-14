defmodule EggTimer.TimerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EggTimer.Timer` context.
  """

  @doc """
  Generate a preset.
  """
  def preset_fixture(attrs \\ %{}) do
    {:ok, preset} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        value: "some value"
      })
      |> EggTimer.Timer.create_preset()

    preset
  end
end
