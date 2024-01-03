extends CharacterBody2D


@export var speed = 300.0
@export var slide = 150.0

func _physics_process(delta):
	var dir = Vector2(0,0)
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	if dir.x or dir.y:
		dir = dir.normalized()
	if dir.x:
		velocity.x = dir.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, slide)
	if dir.y:
		velocity.y = dir.y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, slide)
	move_and_slide()
