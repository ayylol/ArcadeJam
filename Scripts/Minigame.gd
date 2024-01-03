extends Node2D

var wrench_vect = Vector2(0,0)
var deadzone = 0.3
var counter = 0
var prev_rotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	move_wrench()
	
func move_wrench():
	wrench_vect.y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	wrench_vect.x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
	if wrench_vect.length() >= deadzone:
		prev_rotation = rotation
		rotation = wrench_vect.angle()
		if(rotation < -1.5 and rotation > -2 and (prev_rotation >= -1.5 or prev_rotation <= -1.64) ):
			counter += 1
			if counter == 5:
				get_tree().quit()

