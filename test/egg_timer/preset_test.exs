defmodule EggTimer.PresetTest do
  use EggTimer.DataCase

  alias EggTimer.Preset

  describe "timers" do
    alias EggTimer.Preset.Timer

    import EggTimer.PresetFixtures

    @invalid_attrs %{name: nil, value: nil, description: nil}

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert Preset.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert Preset.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      valid_attrs = %{name: "some name", value: "some value", description: "some description"}

      assert {:ok, %Timer{} = timer} = Preset.create_timer(valid_attrs)
      assert timer.name == "some name"
      assert timer.value == "some value"
      assert timer.description == "some description"
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Preset.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()

      update_attrs = %{
        name: "some updated name",
        value: "some updated value",
        description: "some updated description"
      }

      assert {:ok, %Timer{} = timer} = Preset.update_timer(timer, update_attrs)
      assert timer.name == "some updated name"
      assert timer.value == "some updated value"
      assert timer.description == "some updated description"
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = Preset.update_timer(timer, @invalid_attrs)
      assert timer == Preset.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = Preset.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> Preset.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = Preset.change_timer(timer)
    end
  end

  describe "timers" do
    alias EggTimer.Preset.Timer

    import EggTimer.PresetFixtures

    @invalid_attrs %{name: nil, value: nil, description: nil, image_file: nil}

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert Preset.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert Preset.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      valid_attrs = %{
        name: "some name",
        value: "some value",
        description: "some description",
        image_file: "some image_file"
      }

      assert {:ok, %Timer{} = timer} = Preset.create_timer(valid_attrs)
      assert timer.name == "some name"
      assert timer.value == "some value"
      assert timer.description == "some description"
      assert timer.image_file == "some image_file"
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Preset.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()

      update_attrs = %{
        name: "some updated name",
        value: "some updated value",
        description: "some updated description",
        image_file: "some updated image_file"
      }

      assert {:ok, %Timer{} = timer} = Preset.update_timer(timer, update_attrs)
      assert timer.name == "some updated name"
      assert timer.value == "some updated value"
      assert timer.description == "some updated description"
      assert timer.image_file == "some updated image_file"
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = Preset.update_timer(timer, @invalid_attrs)
      assert timer == Preset.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = Preset.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> Preset.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = Preset.change_timer(timer)
    end
  end
end
