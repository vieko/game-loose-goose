extends Area2D

var plPoopSplash := preload("res://Poop/PoopSplash.tscn")

@onready var animatedSprite := $AnimatedSprite2D

@export var speed: float = 500

func _ready():
  animatedSprite.play("one")

func _physics_process(delta):
  position.y -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
  queue_free()


func _on_area_entered(area):
  if area.is_in_group(Globals.Groups.DAMAGEABLES):
    var poopSplash := plPoopSplash.instantiate()
    poopSplash.position = position
    get_parent().add_child(poopSplash)

    area.damage(1)
    queue_free()
