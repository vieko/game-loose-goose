extends Area2D

# DEFINE Variables
@onready var animatedSprite := $AnimatedSprite2D

@export var speed: float = 100
var velocity := Vector2(0,0)

func _process(delta):                                                           # less time sensitive things should go here
  if velocity.x < 0:
    animatedSprite.play("walk_left")
  elif velocity.x > 0:
    animatedSprite.play("walk_right")
  else:
    animatedSprite.play("walk_up")

func _physics_process(delta):                                                   # anything input or time sensitive should go here
  var directionVector := Vector2(0,0)                                           # fixes diagonal acceleration

  if Input.is_action_pressed("move_left"):
    directionVector.x = -1
  elif Input.is_action_pressed("move_right"):
    directionVector.x = 1

  velocity = directionVector.normalized() * speed                               # always one
  position += velocity * delta

  # TODO SHOW animation based on movement direction

  # TODO SET starting position on Y for Broose

  # KEEP Broose within the screen
  var viewRect := get_viewport_rect()
  position.x = clamp(position.x, 0, viewRect.size.x)
