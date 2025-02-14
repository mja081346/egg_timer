defmodule EggTimer.TimerTest do
  use EggTimer.DataCase

  alias EggTimer.Timer

  describe "presets" do
    alias EggTimer.Timer.Preset

    import EggTimer.TimerFixtures

    @invalid_attrs %{name: nil, value: nil, description: nil}

    test "list_presets/0 returns all presets" do
      preset = preset_fixture()
      assert Timer.list_presets() == [preset]
    end

    test "get_preset!/1 returns the preset with given id" do
      preset = preset_fixture()
      assert Timer.get_preset!(preset.id) == preset
    end

    test "create_preset/1 with valid data creates a preset" do
      valid_attrs = %{name: "some name", value: "some value", description: "some description"}

      assert {:ok, %Preset{} = preset} = Timer.create_preset(valid_attrs)
      assert preset.name == "some name"
      assert preset.value == "some value"
      assert preset.description == "some description"
    end

    test "create_preset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timer.create_preset(@invalid_attrs)
    end

    test "update_preset/2 with valid data updates the preset" do
      preset = preset_fixture()

      update_attrs = %{
        name: "some updated name",
        value: "some updated value",
        description: "some updated description"
      }

      assert {:ok, %Preset{} = preset} = Timer.update_preset(preset, update_attrs)
      assert preset.name == "some updated name"
      assert preset.value == "some updated value"
      assert preset.description == "some updated description"
    end

    test "update_preset/2 with invalid data returns error changeset" do
      preset = preset_fixture()
      assert {:error, %Ecto.Changeset{}} = Timer.update_preset(preset, @invalid_attrs)
      assert preset == Timer.get_preset!(preset.id)
    end

    test "delete_preset/1 deletes the preset" do
      preset = preset_fixture()
      assert {:ok, %Preset{}} = Timer.delete_preset(preset)
      assert_raise Ecto.NoResultsError, fn -> Timer.get_preset!(preset.id) end
    end

    test "change_preset/1 returns a preset changeset" do
      preset = preset_fixture()
      assert %Ecto.Changeset{} = Timer.change_preset(preset)
    end
  end
end
