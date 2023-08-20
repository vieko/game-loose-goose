extends Area2D

func _ready():
  $AnimatedSprite2D.play("default")

func _on_timer_timeout():
  queue_free()
