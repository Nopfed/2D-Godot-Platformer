extends KinematicBody2D

#velocity
var v = Vector2(0, 0)
var collectibles = 0
var playing = true
var jumping = false

const SPEED = 300
const MAX_SPEED = 300
const GRAVITY = 30
const JUMP = -615

func _physics_process(_delta):
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
	
	v.y = v.y + GRAVITY if v.y < GRAVITY*30 else v.y
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and playing:
		v.y = JUMP
		jumping = true
		$"Jump Sound".play()
	
	if Input.is_action_just_released("jump") and v.y < -100 and jumping:
		v.y = -100
	
	if jumping and v.y >= 0:
		jumping = false
	
	var snap = Vector2.DOWN * 32 if !jumping else Vector2.ZERO
	
	#calculate movement and floor direction
	v = move_and_slide_with_snap(v, snap, Vector2.UP) if playing else v
	
	
	#inertia/friction
	if !Input.is_action_pressed("right"):
		if !Input.is_action_pressed("left"):
			v.x = lerp(v.x, 0, 0.9)

func bounce():
	v *= -2

func kill():
	playing = false
	$"death sound".play()
	yield($"death sound", "finished")
	get_tree().reload_current_scene()

func _on_death_zone_body_entered(_body):
	kill()
