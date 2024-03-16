extends CanvasLayer

@onready var health_container_scene = %HealthContainer
@onready var plant_container_scene = %PlantContainer


func OnHealthChanged(health:int) -> void:
	for i in health_container_scene.get_child_count():
		health_container_scene.get_child(i).visible = health > i
	
func OnGoldChanged(gold:int) -> void:
	%Gold.text = str(gold)
	
func OnSelectedTowerChanged(towerInfo:TowerInfo) -> void:
	for i in plant_container_scene.get_child_count():
		if towerInfo.Index == i:
			plant_container_scene.get_child(i).custom_minimum_size = Vector2(110,135)
			plant_container_scene.get_child(i).self_modulate = Color(1,1,1,1)
		else:
			plant_container_scene.get_child(i).custom_minimum_size = Vector2.ZERO
			plant_container_scene.get_child(i).self_modulate = Color(1,1,1,0.6)
		
	
	#%SelectedPlant.text = "Selected Plant: " + towerInfo.Name
	#%SelectedPlantCost.text = "Plant Cost: " + str(towerInfo.Cost)

func OnVictoryConditionChanged(victoryCondition:String)-> void:
	pass
	%VictoryConditionLabel.text = victoryCondition
