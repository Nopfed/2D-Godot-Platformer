extends KinematicBody2D

#velocity
var v = Vector2(0, 0)
const speedIncrement = 30
const speedMax = 300

func _physics_process(delta):
	#move to the right
	if Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			v.x += speedIncrement if v.x < speedMax else 0
	
	#move to the left
	if Input.is_action_pressed("left"):
		if !Input.is_action_pressed("right"):
			v.x -= speedIncrement if v.x > -speedMax else 0
	
	v.y = v.y + 30
	
	move_and_slide(v)
	
	#inertia/friction
	if !Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			v.x = lerp(v.x, 0, 0.9)
