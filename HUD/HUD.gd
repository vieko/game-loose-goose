extends Control

var pHealthIcon = preload("res://HUD/LifeIcon.tscn")

@onready var healthContainer := $HealthContainer
@onready var poopMeter := $TextureProgressBar

var poopMax: int = 20
var poopCurrent: int = 20

func _ready():
  #poopContainer.max_value = poopMax
  clearHealth()
  Globals.connect("on_player_health_changed", _on_player_health_changed)
  Globals.connect("on_poop_meter_changed", _on_poop_meter_changed)

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

func clearPoopMeter():
  pass

func setPoopMeter(poop: int):
  #clearPoopMeter()
  poopCurrent += poop
  poopCurrent = clamp(poopCurrent, 0, poopMax)
  poopMeter.value = poopCurrent
  print("Broose's Poop: %s" % poopCurrent)

func _on_poop_meter_changed(poop: int):
  setPoopMeter(poop)
