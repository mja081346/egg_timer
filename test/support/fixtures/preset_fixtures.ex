defmodule EggTimer.PresetFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EggTimer.Preset` context.
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
      |> EggTimer.Preset.create_timer()

    timer
  end

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_file: "some image_file",
        name: "some name",
        value: "some value"
      })
      |> EggTimer.Preset.create_timer()

    timer
  end
end
