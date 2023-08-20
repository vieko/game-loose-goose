extends Area2D

@export var minSpeed: float = 60
@export var maxSpeed: float = 90

@export var health: int = 3

var speed: float = 0

func _ready():
  # TODO change the angle
  speed = randf_range(minSpeed, maxSpeed)
  add_to_group(Globals.Groups.DAMAGEABLES)

func _physics_process(delta):
  position.y += speed * delta

func damage(amount: int):
  health -= amount
  if health <= 0:
    queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
  queue_free()
