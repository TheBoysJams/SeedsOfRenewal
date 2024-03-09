extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the buttons to their signals
	$MarginContainer/VBoxContainer/ResumeButton.connect("pressed", Callable(self, "_on_ResumeButton_pressed"))
	$MarginContainer/VBoxContainer/ExitToMenuButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))
	# Initially hide the pause menu
	visible = false

func _on_ResumeButton_pressed():
	# Resume the game
	get_tree().paused = false
	visible = false


func _on_ExitButton_pressed():
	# Exit to the main menu
	var main_menu_scene = load("res://UI/main_menu.tscn") as PackedScene
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)

func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if get_tree().paused:
			get_tree().paused = false
			visible = false
		else:
			get_tree().paused = true
			visible = true
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
