class_name Player

extends Area2D

export (int) var speed = 256

var lastPosition = Vector2()
var targetPosition = Vector2()
var moveDirection = Vector2()

onready var rayCast = get_node("RayCast2D")
onready var animationTree = get_node("AnimationTree")
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	position = position.snapped(Vector2(Global.tileSize, Global.tileSize))
	lastPosition = position
	targetPosition = position

func _process(delta):
	if rayCast.is_colliding():
		position = lastPosition
		targetPosition = lastPosition
		if rayCast.get_collider() is Pushable:
			rayCast.get_collider().get_pushed(moveDirection)
	else:
		position += moveDirection * speed * delta
		#if moved more than 64 pixels, snap back to target position
		if position.distance_to(lastPosition) >= Global.tileSize - speed * delta:
			position = targetPosition
			animationState.travel("idle")
	
	if position == targetPosition:
		get_moveDirection()
		lastPosition = position
		targetPosition += moveDirection * Global.tileSize

var LEFT = false
var RIGHT = false
var UP = false
var DOWN = false

func _unhandled_input(_event):
	LEFT = Input.is_action_pressed("move_left")
	RIGHT = Input.is_action_pressed("move_right")
	UP = Input.is_action_pressed("move_up")
	DOWN = Input.is_action_pressed("move_down")

func get_moveDirection():
	moveDirection.x = -int(LEFT) + int(RIGHT)
	moveDirection.y = -int(UP) + int(DOWN)
	
	if not moveDirection.x == 0 and not moveDirection.y == 0:
		moveDirection = Vector2.ZERO
	
	if not moveDirection == Vector2.ZERO:
		rayCast.cast_to = moveDirection * Global.tileSize / 2
		animationTree.set("parameters/idle/blend_position", moveDirection)
		animationTree.set("parameters/move/blend_position", moveDirection)
		animationState.travel("move")
