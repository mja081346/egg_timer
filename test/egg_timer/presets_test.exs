defmodule EggTimer.PresetsTest do
  use EggTimer.DataCase

  alias EggTimer.Presets

  describe "timers" do
    alias EggTimer.Presets.Timer

    import EggTimer.PresetsFixtures

    @invalid_attrs %{name: nil, value: nil, description: nil}

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert Presets.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert Presets.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      valid_attrs = %{name: "some name", value: "some value", description: "some description"}

      assert {:ok, %Timer{} = timer} = Presets.create_timer(valid_attrs)
      assert timer.name == "some name"
      assert timer.value == "some value"
      assert timer.description == "some description"
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Presets.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()

      update_attrs = %{
        name: "some updated name",
        value: "some updated value",
        description: "some updated description"
      }

      assert {:ok, %Timer{} = timer} = Presets.update_timer(timer, update_attrs)
      assert timer.name == "some updated name"
      assert timer.value == "some updated value"
      assert timer.description == "some updated description"
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = Presets.update_timer(timer, @invalid_attrs)
      assert timer == Presets.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = Presets.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> Presets.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = Presets.change_timer(timer)
    end
  end
end
