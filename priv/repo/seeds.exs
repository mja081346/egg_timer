# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EggTimer.Repo.insert!(%EggTimer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias EggTimer.Preset

Preset.create_timer(%{
  name: "Runny Yolk",
  value: "06:00",
  image_file: "runny_yolk.jpg",
  description: "Barely set whites, runny yolk"
})

Preset.create_timer(%{
  name: "Soft Boiled",
  value: "08:00",
  image_file: "soft_boiled.jpg",
  description: "Soft-set whites, jammy yolks"
})

Preset.create_timer(%{
  name: "Hard Boiled",
  value: "10:00",
  image_file: "hard_boiled.jpg",
  description: "Firm whites, fully cooked yolks"
})

Preset.create_timer(%{
  name: "Overcooked",
  value: "15:00",
  image_file: "overcooked.jpg",
  description: "Rubbery whites, dry yolk"
})
