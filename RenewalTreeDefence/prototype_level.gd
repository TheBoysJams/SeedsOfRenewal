extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if not get_tree().paused:
			# Pause the game
			get_tree().paused = true
			$PauseMenu.visible = true
		else:
			# Resume the game (can also be handled via the Resume button)
			get_tree().paused = false
			$PauseMenu.visible = false
