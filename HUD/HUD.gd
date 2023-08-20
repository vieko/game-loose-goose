extends Control

var pHealthIcon = preload("res://HUD/LifeIcon.tscn")

@onready var healthContainer := $HealthContainer

func _ready():
  clearHealth()
  #setHealth(Globals.startHeatlh)
  Globals.connect("on_player_health_changed", _on_player_health_changed)

func clearHealth():
  for child in healthContainer.get_children():
    healthContainer.remove_child(child)
    child.queue_free()

func setHealth(health: int):
  clearHealth()
  for i in range(health):
    healthContainer.add_child(pHealthIcon.instantiate())

func _on_player_health_changed(life: int):
  setHealth(life)

