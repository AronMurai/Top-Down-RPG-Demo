class_name Pushable

extends Area2D

onready var spawnPosition = position
onready var raycast = get_node("Raycast2D")
onready var collisionShape = get_node("CollisionShape2D")
onready var tween = get_node("Tween")

func get_pushed(pushDirection : Vector2):
	raycast.cast_to = pushDirection * Global.tileSize
	yield(get_tree(), "idle_frame")
	if not raycast.is_colliding():
		tween.interpolate_property(self, "position",
		position, (position + pushDirection * Global.tileSize).snapped(Vector2(Global.tileSize, Global.tileSize)),
		0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func reset_position():
	position = spawnPosition
