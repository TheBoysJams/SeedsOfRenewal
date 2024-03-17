extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the buttons to their signals
	# Initially hide thepause menu
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if get_tree().paused && visible:
			get_tree().paused = false
			visible = false
		elif !get_tree().paused:
			get_tree().paused = true
			visible = true
			

func _on_resume_button_pressed():
	# Resume the game
	get_tree().paused = false
	visible = false

func _on_exit_to_menu_button_pressed():
	var main_menu_scene = load("res://UI/main_menu.tscn") as PackedScene
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)
