extends Area2D

@export var minSpeed: float = 40
@export var maxSpeed: float = 60
@export var endSpeed: float = Globals.cameraSpeed

@export var health: int = 3

@onready var animatedSprite := $AnimatedSprite2D

var speed: float = 0
var playerInArea: Player = null
var isDead: bool = false

func _ready():
  # TODO change the angle
  speed = randf_range(minSpeed, maxSpeed)
  animatedSprite.play()
  add_to_group(Globals.Groups.DAMAGEABLES)

func _process(delta):
  if playerInArea != null and !isDead:
    playerInArea.damage(1)

func _physics_process(delta):
  position.y += speed * delta

func damage(amount: int):
  health -= amount
  if health <= 0:
    speed = endSpeed
    isDead = true
    animatedSprite.stop()
    queue_free()
    #modulate = Color(1, 0, 0, 1)
    print("PORCUPINE IS DEAD!")

func _on_visible_on_screen_notifier_2d_screen_exited():
  queue_free()


func _on_area_entered(area):
  if area is Player:
    playerInArea = area


func _on_area_exited(area):
  if area is Player:
    playerInArea = null
