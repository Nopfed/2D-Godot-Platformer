extends KinematicBody2D

#velocity
var v = Vector2(0, 0)
var collectibles = 0
var playing = true
var jumping = false
var walljumpingRight = false
var walljumpingLeft = false
onready var floortype = "normal"

const SPEED = 300
const MAX_SPEED = 300
const GRAVITY = 30
const JUMP = -615

func _physics_process(_delta):
	#move to the right
	if Input.is_action_pressed("right") and !walljumpingLeft:
		if !Input.is_action_pressed("left"):
			#v.x += SPEED if v.x < MAX_SPEED else 0
			if floortype == "sticky":
				v.x = SPEED*.5
			else:
				v.x = SPEED
	
	
	#move to the left
	if Input.is_action_pressed("left") and !walljumpingRight:
		if !Input.is_action_pressed("right"):
			#v.x -= SPEED if v.x > -MAX_SPEED else 0
			if floortype == "sticky":
				v.x = -SPEED*.5
			else:
				v.x = -SPEED

	
	v.y = v.y + GRAVITY if v.y <= -JUMP*2 else v.y
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and playing:
		if floortype == "sticky":
			v.y = JUMP*.7
		else:
			v.y = JUMP
			
		jumping = true
		$"Jump Sound".play()
	
	#wall-jumping
#	if Input.is_action_just_pressed("jump") and is_on_wall() and !is_on_floor() and playing:
#		floortype = "bouncy"
#		if Input.is_action_pressed("right") and !Input.is_action_pressed("left"):
#			walljumpingLeft = true
#			walljumpingRight = false
#			v = Vector2(-SPEED*2, JUMP)
#			jumping = true
#			$"Jump Sound".play()
#		elif Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
#			walljumpingRight = true
#			walljumpingLeft = false
#			v = Vector2(SPEED*2, JUMP)
#			jumping = true
#			$"Jump Sound".play()
			
	if is_on_wall() and !is_on_floor() and Input.is_action_pressed("left") and !Input.is_action_pressed("right") and Input.is_action_just_pressed("jump"):
		floortype = "bouncy"
		walljumpingRight = true
		walljumpingLeft = false
		v = Vector2(SPEED*2, JUMP*1.1)
		jumping = true
		$"Jump Sound".play()
	elif is_on_wall() and !is_on_floor() and Input.is_action_pressed("right") and !Input.is_action_pressed("left") and Input.is_action_just_pressed("jump"):
		floortype = "bouncy"
		walljumpingLeft = true
		walljumpingRight = false
		v = Vector2(-SPEED*2, JUMP*1.1)
		jumping = true
		$"Jump Sound".play()
	
	if Input.is_action_just_released("jump") and v.y < -100 and jumping:
		v.y = -100
	
	if jumping and v.y >= 0:
		jumping = false
	
	if (walljumpingRight or walljumpingLeft) and is_on_floor():
		walljumpingRight = false
		walljumpingLeft = false
	
	var snap = Vector2.DOWN * 32 if !jumping else Vector2.ZERO
	
	#calculate movement and floor direction
	v = move_and_slide_with_snap(v, snap, Vector2.UP) if playing else v
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("ice"):
			friction("icy")
			break
		elif collision.collider.is_in_group("goop"):
			friction("sticky")
			break
		else:
			friction("normal")
			break

	
	#inertia/friction
	if floortype == "icy":
		v.x = lerp(v.x, 0, 0.01)
	elif floortype == "sticky":
		v.x = lerp(v.x, 0, 1)
	elif floortype == "bouncy":
		v.x = lerp(v.x, 0, 0.1)
	else:
		v.x = lerp(v.x, 0, 0.5)

func friction(type):
	floortype = type

func bounce():
	floortype = "bouncy"
	v = Vector2(v.x, JUMP*2)


func kill():
	playing = false
	$"death sound".play()
	yield($"death sound", "finished")
	get_tree().reload_current_scene()

func _on_death_zone_body_entered(_body):
	kill()
