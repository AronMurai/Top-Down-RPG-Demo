extends Node

onready var bookshelves = get_node("Bookshelves")
onready var resetTriggers = get_node("ResetTriggers")
onready var settings = get_node("Settings")

func _ready():
	for bookshelf in bookshelves.get_children():
		for resetTrigger in resetTriggers.get_children():
			resetTrigger.connect("reset_bookshelf_positions", bookshelf, "reset_position")

