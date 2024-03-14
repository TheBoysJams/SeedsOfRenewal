extends Control

func OnHealthChanged(health:int) -> void:
	$VBoxContainer/Health.text = "Health: " + str(health)
	
func OnGoldChanged(gold:int) -> void:
	$VBoxContainer/Gold.text = "Gold: " + str(gold)
	
func OnSelectedTowerChanged(towerInfo:TowerInfo) -> void:
	$VBoxContainer/SelectedPlant.text = "Selected Plant: " + towerInfo.Name
	$VBoxContainer/SelectedPlantCost.text = "Plant Cost: " + str(towerInfo.Cost)
