extends CanvasLayer

@export var levelToLoad: PackedScene

@onready var play_button: Button = %PlayButton
@onready var exit_button: Button = %ExitButton


func on_play_pressed():
	get_tree().change_scene_to_packed(levelToLoad)


func on_exit_pressed():
	get_tree().quit()
