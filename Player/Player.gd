extends Area2D

class_name Player

# TODO Add player lives
# TODO Add poop meter

# TODO Add porcupine sprites
# TODO Add squirrel sprites

# TODO Add food items
# TODO Spawn food

# TODO Handle Broose eats
# TODO Handle Broose hovers

# TODO Spawn more enemies

# TODO Add sounds

# TODO Add vignette

# TODO Add Start Screen
# TODO Add Game Over Screen

# TODO Stop poop collision when enemy is down
# TODO Broose is invincible when jumping and hovering

# TODO Random Background Sections

# PRELOAD Scenes
var plPoop := preload("res://Poop/Poop.tscn")

# DEFINE Variables
@onready var animatedSprite := $AnimatedSprite2D
@onready var poopingPositions := $PoopingPositions
@onready var poopDelayTimer := $PoopDelayTimer
@onready var ignoreDamageTimer := $IgnoreDamageTimer

@export var speed: float = Globals.walkingSpeed
@export var poopDelay: float = 0.1
@export var health: int = Globals.startHealth
@export var damageIgnoredTime := 0.5

var velocity := Vector2(0,0)
var current_mode = Globals.Modes.WALK
var isJumping: bool = false
var isHovering:bool = false
var isToggling:bool = false

func _ready():
  animatedSprite.play("walk")
  Globals.emit_signal("on_player_health_changed", health)
  print("CURRENT MODE: %s" % current_mode)

# NON TIME SENSITIVE THINGS SHOULD GO HERE
func _process(delta):
  # CHECK if shooting
  if current_mode == Globals.Modes.POOP and !isJumping and !isHovering and Input.is_action_pressed("poop") and poopDelayTimer.is_stopped():
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
  #animatedSprite.play("walk")
  pass

func poop():
  #animatedSprite.play("poop")
  pass

func flipToWalk():
  animatedSprite.play("flip_to_walk")
  isJumping = true
  isHovering = false
  isToggling = true
  var frameCount = 8
  var frameRate = 5
  var animationLength = frameCount / frameRate
  var timer := get_tree().create_timer(animationLength)
  await timer.timeout
  isJumping = false
  isToggling = false
  current_mode = Globals.Modes.WALK
  animatedSprite.play("walk")
  print("CURRENT MODE: %s" % current_mode)

func flipToPoop():
  animatedSprite.play("flip_to_poop")
  isJumping = true
  isHovering = false
  isToggling = true
  var frameCount = 8
  var frameRate = 5
  var animationLength = frameCount / frameRate
  var timer := get_tree().create_timer(animationLength)
  await timer.timeout
  isJumping = false
  isToggling = false
  current_mode = Globals.Modes.POOP
  animatedSprite.play("poop")
  print("CURRENT MODE: %s" % current_mode)

func damage(amount: int):
  if !ignoreDamageTimer.is_stopped():
    return
  ignoreDamageTimer.start(damageIgnoredTime)

  health -= amount
  Globals.emit_signal("on_player_health_changed", health)
  print("Broose's Health: %s" % health)

  if health <= 0:
    print("Broose is DEAD!")
    queue_free()

func toggle_mode():
  match current_mode:
    Globals.Modes.WALK:
      if !isToggling:
        flipToPoop()
    Globals.Modes.POOP:
      if !isToggling:
        flipToWalk()

  #current_mode = Globals.Modes.WALK if current_mode == Globals.Modes.POOP else Globals.Modes.POOP
  #print("Broose is walking!" if current_mode == Globals.Modes.WALK else "Broose is pooping!")

func _on_ignore_damage_timer_timeout():
  pass
