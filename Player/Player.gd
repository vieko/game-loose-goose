extends Area2D

# DEFINE Variables
@onready var animatedSprite := $AnimatedSprite2D

@export var speed: float = 100
var velocity := Vector2(0,0)

enum Modes { WALK, POOP }
var current_mode = Modes.WALK

# NON TIME SENSITIVE THINGS SHOULD GO HERE
func _process(delta):
  # what animation should be shown?
  if velocity.x < 0:
    animatedSprite.play("walk_left")
  elif velocity.x > 0:
    animatedSprite.play("walk_right")
  else:
    animatedSprite.play("walk_up")

# TIME SENSITIVE THINGS SHOULD GO HERE
func _physics_process(delta):
  var directionVector := Vector2(0,0)                                           # fixes diagonal acceleration

  # CHECK on state
  match current_mode:
    Modes.WALK:
      walk()
    Modes.POOP:
      poop()

  # change the walking direction based on keys pressed
  if Input.is_action_pressed("move_left"):
    directionVector.x = -1
  elif Input.is_action_pressed("move_right"):
    directionVector.x = 1

  if Input.is_action_just_pressed("flip"):
    toggle_mode()

  velocity = directionVector.normalized() * speed                               # always one
  position += velocity * delta

  # TODO SHOW animation based on movement direction
  # TODO SET starting position on Y for Broose

  # KEEP Broose within the screen
  var viewRect := get_viewport_rect()
  position.x = clamp(position.x, 0, viewRect.size.x)

func walk():
  print("Broose is walking!")

func poop():
  print("Broose is pooping!")

func toggle_mode():
  current_mode = Modes.WALK if current_mode == Modes.POOP else Modes.POOP
  match current_mode:
    Modes.WALK:
      print("Switched to Walk Mode")
    Modes.POOP:
      print("Switched to Poop Mode")
