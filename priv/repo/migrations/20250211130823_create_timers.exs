defmodule EggTimer.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :name, :string
      add :value, :string
      add :image_file, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
