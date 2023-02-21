extends Area2D

signal reset_bookshelf_positions

func _on_ResetTriggers_area_entered(area):
	if area is Player:
		emit_signal("reset_bookshelf_positions")
