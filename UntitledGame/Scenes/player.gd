extends CharacterBody2D


const MOVE_SPEED = 700
const JUMP_POWER = -1500
const WALL_JUMP_POWER = 1000

const ACCELERATION = 50
const FRICTION = 100
const WALL_FRICTION = 150

const GRAVITY = 120

var cling_left = false
var cling_right = false
var cling_timer = 0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		if is_on_floor():
			velocity.x = direction * MOVE_SPEED
		else:
			velocity.x = move_toward(velocity.x, direction * MOVE_SPEED, MOVE_SPEED*0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, 60)
		
	if is_on_wall() and direction<0:
		cling_left = true
		#velocity.y = 0
	if is_on_wall() and direction>0:
		cling_right = true
		#velocity.y = 0
	if direction == 0:
		cling_left = false
		cling_right = false
	
	"""
	if false and (cling_left or cling_right):
		velocity.y += WALL_FRICTION
	else:
		pass
	"""
	
	velocity.y += GRAVITY
		
	
	move_and_slide()
	jump()
	
	
func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_POWER
		if cling_left:
			velocity.y = JUMP_POWER
			velocity.x = WALL_JUMP_POWER
		if cling_right:
			velocity.y = JUMP_POWER
			velocity.x = -WALL_JUMP_POWER
"""
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var wall_jump_valid = left_collision or right_collision
	if right_collision:
		print("right!")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or wall_jump_valid):
		velocity.y = JUMP_VELOCITY

	
	move_and_slide()
"""
	
	
