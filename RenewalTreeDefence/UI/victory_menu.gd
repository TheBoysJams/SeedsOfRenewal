extends CanvasLayer

@export var nextLevel:PackedScene
@onready var victory_sfx: AudioStreamPlayer = $VictorySFX

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	if not nextLevel:
		%NextLevelButton.visible = false
		%VictoryLabel.text = "The forest has been renewed, thank you for playing!"
		
func _on_nextLevel_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(nextLevel)
	visible = false

func _on_exit_to_menu_button_pressed():
	var main_menu_scene = load("res://UI/main_menu.tscn") as PackedScene
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)


func OnVictory() -> void:
	if victory_sfx:
		victory_sfx.play()
	get_tree().paused = true
	visible = true
