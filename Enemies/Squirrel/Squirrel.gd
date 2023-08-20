extends Area2D

var plSquirrelExplode := preload("res://Enemies/Squirrel/SquirrelExplode.tscn")

@export var minSpeed: float = 100
@export var maxSpeed: float = 140

@export var health: int = 1

var speed: float = 0
var playerInArea: Player = null

func _ready():
  # TODO change the angle
  speed = randf_range(minSpeed, maxSpeed)
  add_to_group(Globals.Groups.DAMAGEABLES)

func _process(delta):
  if playerInArea != null:
    playerInArea.damage(1)

func _physics_process(delta):
  position.y += speed * delta

func damage(amount: int):
  health -= amount
  if health <= 0:
    var effect := plSquirrelExplode.instantiate()
    effect.position = position
    get_parent().add_child(effect)
    queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
  queue_free()


func _on_area_entered(area):
  if area is Player:
    playerInArea = area


func _on_area_exited(area):
  if area is Player:
    playerInArea = null
