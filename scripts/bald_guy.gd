extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var x_direction = 0
var y_direction = 0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	get_player_input()
	set_player_velocity()
	set_player_rotation()
	set_animation()
	
	move_and_slide()
	
	
func get_player_input():
	x_direction = Input.get_axis("move_left", "move_right")
	y_direction = Input.get_axis("move_up", "move_down")
		
func set_player_velocity():
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
func set_animation():
	if y_direction or x_direction:
		$Walking.visible = true
		$Walking.play("BaldGuyWalking")
		$Idle.visible = false
	else:
		$Idle.visible = true
		$Walking.visible = false
	
	
func set_player_rotation():
	var offset_angle = PI / 2
	var mouse_position = get_global_mouse_position()
	var mouse_direction = mouse_position - global_position
	rotation = mouse_direction.angle() + offset_angle
