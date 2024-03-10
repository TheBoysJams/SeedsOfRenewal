extends MarginContainer

@export var levelToLoad: PackedScene

func _ready():
	pass

func _on_start_button_pressed() -> void:
	# Load the level scene as a PackedScene object
	# Ensure the levelToLoad is not null
	if levelToLoad:
		# Change to the loaded scene
		get_tree().change_scene_to_packed(levelToLoad)

func _on_exit_button_pressed() -> void:
		# Quit the game
	get_tree().quit()
