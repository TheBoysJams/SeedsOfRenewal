extends CanvasLayer

@export var levelToLoad: PackedScene

@onready var play_button: Button = %PlayButton
@onready var exit_button: Button = %ExitButton


func _ready():
	play_button.pressed.connect(on_play_pressed)
	exit_button.pressed.connect(on_exit_pressed)

func on_play_pressed():
	get_tree().change_scene_to_packed(levelToLoad)


func on_exit_pressed():
	get_tree().quit()
