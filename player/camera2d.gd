extends Camera2D
onready var gridSize = OS.get_window_size()
var gridPosition = Vector2()

func _ready():
	gridPosition.x = floor(get_parent().position.x / gridSize.x)
	gridPosition.y = floor(get_parent().position.y / gridSize.y)
	position = gridPosition * gridSize
	set_as_toplevel(true)
	updateGridPosition()
	yield(get_tree(), "idle_frame")
	smoothing_enabled = true

func _physics_process(_delta):
	updateGridPosition()

#we need to change position 
func updateGridPosition():
	var x = floor(get_parent().position.x / gridSize.x)
	var y = floor(get_parent().position.y / gridSize.y)
	var newGridPosition = Vector2(x, y)
	if not gridPosition == newGridPosition:
		gridPosition = newGridPosition
		position = gridPosition * gridSize
