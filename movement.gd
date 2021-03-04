extends KinematicBody2D

#velocity
var v = Vector2(0, 0)

const SPEED = 300
const MAX_SPEED = 300
const GRAVITY = 30
const JUMP = -600

func _physics_process(delta):
	#move to the right
	if Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			#v.x += SPEED if v.x < MAX_SPEED else 0
			v.x = SPEED
	
	#move to the left
	if Input.is_action_pressed("left"):
		if !Input.is_action_pressed("right"):
			#v.x -= SPEED if v.x > -MAX_SPEED else 0
			v.x = -SPEED
	
	v.y = v.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		v.y = JUMP
	
	#calculate movement and floor direction
	v = move_and_slide(v, Vector2.UP)
	
	#inertia/friction
	if !Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			v.x = lerp(v.x, 0, 0.9)
