extends CanvasLayer

@export var nextLevel:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	if not nextLevel:
		%NextLevelButton.visible = false
		%VictoryLabel.text = "You win!"
		
func _on_nextLevel_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(nextLevel)
	visible = false

func _on_exit_to_menu_button_pressed():
	var main_menu_scene = load("res://UI/main_menu.tscn") as PackedScene
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)


func OnVictory() -> void:
	get_tree().paused = true
	visible = true
