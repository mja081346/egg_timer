defmodule EggTimer.Preset.Timer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timers" do
    field :name, :string
    field :value, :string
    field :description, :string
    field :image_file, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:name, :value, :image_file, :description])
    |> validate_required([:name, :value, :image_file, :description])
    |> unique_constraint(:name)
  end
end
