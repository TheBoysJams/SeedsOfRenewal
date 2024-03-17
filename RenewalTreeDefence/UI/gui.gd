extends CanvasLayer

@export var player: Player

@onready var health_container_scene = %HealthContainer
@onready var plant_container_scene = %PlantContainer
@onready var complete_level_button = $MarginContainer/VBoxContainer/CompleteLevelButton
@onready var win_condition_label = %WinConditionLabel
@onready var check_box: CheckBox = $MarginContainer/VBoxContainer/CheckBox

signal Victory()

var victory_condition: int = 99999


func _ready():
	complete_level_button.disabled = true
	check_box.button_pressed = PlayerGlobal.auto_complete_state


func OnHealthChanged(health:int) -> void:
	for i in health_container_scene.get_child_count():
		health_container_scene.get_child(i).visible = health > i
	
func OnGoldChanged(gold:int) -> void:
	%GoldLabel.text = str(gold)
	if gold >= victory_condition:
		complete_level_button.disabled = false
		if check_box.button_pressed == true:
			Victory.emit()
	
func OnSelectedTowerChanged(towerInfo:TowerInfo) -> void:
	for i in plant_container_scene.get_child_count():
		if towerInfo.Index == i:
			plant_container_scene.get_child(i).find_child("PlantPanelContainer").custom_minimum_size = Vector2(110,135)
			plant_container_scene.get_child(i).find_child("PlantPanelContainer").self_modulate = Color(1,1,1,1)
			plant_container_scene.get_child(i).rotation_speed = 0.1
		else:
			plant_container_scene.get_child(i).find_child("PlantPanelContainer").custom_minimum_size = Vector2.ZERO
			plant_container_scene.get_child(i).find_child("PlantPanelContainer").self_modulate = Color(1,1,1,0.6)
			plant_container_scene.get_child(i).rotation_speed = 0.0


func OnVictoryConditionChanged(victoryCondition:int)-> void:
	victory_condition = victoryCondition
	win_condition_label.text = "Required: " + str(victoryCondition)


func _on_mushroom_panel_gui_input(event):
	if event.is_action_pressed("left_click"):
		player.selectedTowerIndex = 0



func _on_tree_panel_gui_input(event):
	if event.is_action_pressed("left_click"):
		player.selectedTowerIndex = 1


func _on_complete_level_button_pressed():
	Victory.emit()


func _on_check_box_toggled(toggled_on):
	PlayerGlobal.auto_complete_state = toggled_on
