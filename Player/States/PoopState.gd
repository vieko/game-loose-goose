extends State

class_name PoopState

func _ready():
  animated_sprite.play("poop")

func _flip_direction():
  animated_sprite.flip_h = not animated_sprite.flip_h

func move_left():
  if animated_sprite.flip_h:
    change_state.call_func("walk")

func move_right():
  pass

func _process(delta):
  pass
