extends MarginContainer


func _ready():
	$VBoxContainer/StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	$VBoxContainer/ExitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))

func _on_StartButton_pressed():
	# Load the level scene as a PackedScene object
	var scene = load("res://prototype_level.tscn") as PackedScene
	# Ensure the scene is not null
	if scene:
		# Change to the loaded scene
		get_tree().change_scene_to_packed(scene)

func _on_ExitButton_pressed():
	# Quit the game
	get_tree().quit()
