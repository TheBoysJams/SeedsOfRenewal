extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the buttons to their signals
	# Initially hide the pause menu
	visible = false

func _on_resume_button_pressed():
	# Resume the game
	get_tree().paused = false
	get_tree().reload_current_scene()
	visible = false
	


func _on_exit_to_menu_button_pressed():
	var main_menu_scene = load("res://UI/main_menu.tscn") as PackedScene
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)
