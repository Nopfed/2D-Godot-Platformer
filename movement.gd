extends KinematicBody2D

#velocity
var v = Vector2(0, 0)

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			v.x += 30 if v.x < 300 else 0
	
	if Input.is_action_pressed("left"):
		if !Input.is_action_pressed("right"):
			v.x -= 30 if v.x > -300 else 0
	
	move_and_slide(v)
	
	if !Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			v.x = lerp(v.x, 0, 0.9)
