extends Area2D

# TODO SHOW animation based on movement direction
# TODO SET starting position on Y for Broose
# TODO Random Background Sections

# PRELOAD Scenes
var plPoop := preload("res://Poop/Poop.tscn")

# DEFINE Variables
@onready var animatedSprite := $AnimatedSprite2D
@onready var poopingPositions := $PoopingPositions
@onready var poopDelayTimer := $PoopDelayTimer

@export var speed: float = 100
@export var poopDelay: float = 0.1

var velocity := Vector2(0,0)
var current_mode = Globals.Modes.WALK

# NON TIME SENSITIVE THINGS SHOULD GO HERE
func _process(delta):
  # what animation should be shown?
  if velocity.x < 0:
    animatedSprite.play("walk_left")
  elif velocity.x > 0:
    animatedSprite.play("walk_right")
  else:
    animatedSprite.play("walk_up")

  # CHECK if shooting
  if current_mode == Globals.Modes.POOP and Input.is_action_pressed("poop") and poopDelayTimer.is_stopped():
    poopDelayTimer.start(poopDelay)
    for child in poopingPositions.get_children():
      var poop := plPoop.instantiate()
      poop.global_position = child.global_position
      get_tree().current_scene.add_child(poop)
  elif current_mode == Globals.Modes.WALK and Input.is_action_pressed("poop"):
    print("Broose can't drop a deuce when walking!")

# TIME SENSITIVE THINGS SHOULD GO HERE
func _physics_process(delta):
  var directionVector := Vector2(0,0)

  # CHECK on state
  match current_mode:
    Globals.Modes.WALK:
      walk()
    Globals.Modes.POOP:
      poop()

  # CHANGE the walking direction based on keys pressed
  if Input.is_action_pressed("move_left"):
    directionVector.x = -1
  elif Input.is_action_pressed("move_right"):
    directionVector.x = 1

  # TOGGLE modes
  if Input.is_action_just_pressed("flip"):
    # TODO toggle should only be possible after X time has passed
    toggle_mode()

  velocity = directionVector.normalized() * speed
  position += velocity * delta

  # KEEP Broose within the screen
  var viewRect := get_viewport_rect()
  position.x = clamp(position.x, 0, viewRect.size.x)

func walk():
  print("Broose is walking!")

func poop():
  print("Broose is pooping!")

func toggle_mode():
  current_mode = Globals.Modes.WALK if current_mode == Globals.Modes.POOP else Globals.Modes.POOP

