extends Node2D

@export var swing_speed := 300
@export var windup_speed := 100
@export var swing_angle := 120 # Degrees
var swinging := false
var winding_up := false
var resetting := false
var swing_direction := 1 # 1 for clockwise, -1 for counterclockwise
var current_angle := 0

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		start_swing()

func start_swing():
	if not swinging and not winding_up:
		winding_up = true
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if winding_up:
		var swing_step = windup_speed * delta * swing_direction
		current_angle += swing_step
		rotation_degrees = current_angle
		
	if swinging:
		var swing_step = swing_speed * delta * swing_direction
		current_angle += swing_step
		rotation_degrees = current_angle
		
	if current_angle >= (swing_angle / 2) and winding_up:
		swing_direction *= -1 #reverse direction
		winding_up = false
		swinging = true
		
	if current_angle == (swing_angle / 2) * -1 and swing_direction == -1: #Swing complete
		swinging = false
		swing_direction = 1 # reset direction
		resetting = true
	
	if current_angle != 0 and resetting:
		var swing_step = windup_speed * delta * swing_direction
		current_angle += swing_step
		rotation_degrees = current_angle
	
	if current_angle == 0 and resetting:
		resetting = false
