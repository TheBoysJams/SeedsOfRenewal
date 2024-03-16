extends CanvasLayer

@export var levelToLoad: PackedScene


func on_play_pressed():
	get_tree().change_scene_to_packed(levelToLoad)


func on_exit_pressed():
	get_tree().quit()
