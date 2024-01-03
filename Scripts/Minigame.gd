extends Node2D

var wrench_vect = Vector2(0,0)
var deadzone = 0.3
var counter = 0
#var prev_rotation = 0
var segment_dict = {"0" : [-PI, -3*PI/4], "1" : [-3*PI/4, PI/-2], "2": [-PI/2, PI/-4], "3": [-PI/4, 0.0], "4": [0.0, PI/4], "5": [PI/4, PI/2], "6": [PI/2, 3*PI/4], "7": [3*PI/4, PI]}
var prev_segment = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	print(segment_dict)
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_accept"):
		check_progress()
	move_wrench()
	
func move_wrench():
	wrench_vect.y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	wrench_vect.x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
	if wrench_vect.length() >= deadzone:
		rotation = wrench_vect.angle()
		analyze_move(wrench_vect.angle())

func analyze_move(angle):
	var cur_segment
	for key in segment_dict:
		var range = segment_dict[key]
		if range[0] <= rotation and rotation <= range[1]:
			cur_segment = int(key)
			break
	if prev_segment > -1:
		if cur_segment == (prev_segment + 1) % 8:
			counter += 1
		elif cur_segment == (prev_segment - 1) % 8:
			counter -= 1
	if counter >= 48:
		print("too tight")
	elif counter >= 40:
		print("You made it")
	elif counter <= -40:
		print("too loose, you failed!")
		get_tree().quit()
	prev_segment = cur_segment
	#var cur_segment = 

func check_progress():
	if counter in range(40, 48):
		print("success")
		get_tree().quit()
	if counter >= 48:
		print("too tight, loosen it a bit")
	if counter in range(-40, 40):
		print("Keep tightening")
