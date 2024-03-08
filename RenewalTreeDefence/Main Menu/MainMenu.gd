extends MarginContainer

func _ready():
	$StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	$ExitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))
	$VolumeSlider.connect("value_changed", Callable(self, "_on_VolumeSlider_value_changed"))

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

func _on_VolumeSlider_value_changed(value):
	# Adjust the volume. This is a placeholder for wherever you manage your game's audio.
	# You might need to adjust this based on how you've implemented audio in your game.
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
