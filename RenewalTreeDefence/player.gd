extends Camera3D
class_name Player 

@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var gridmap: GridMap
@export var towerManager: TowerManager
@export var startingGold = 20
@export var startingHealth = 5
@onready var defeat_menu: Control = $"../DefeatMenu"


var health:
	set(hp_in):
		health = hp_in
		$GUI/VBoxContainer/Health.text = "Health: " + str(health)
		if(health) == 0:
			get_tree().paused = true
			defeat_menu.visible = true

var selectedTowerIndex:int:
	set(index_in):
		selectedTowerIndex = index_in
		$GUI/VBoxContainer/SelectedPlant.text = "Selected Plant: " + towerManager.towers[selectedTowerIndex].Name
		$GUI/VBoxContainer/SelectedPlantCost.text = "Plant Cost: " + str(towerManager.towers[selectedTowerIndex].Cost)

var gold: int:
	set(gold_in):
		gold = max(gold_in,0)
		$GUI/VBoxContainer/Gold.text = "Gold: " + str(gold)

enum TileType {
	Dirt = 0,
	Grass = 1,
	Leaves = 2
}

func _ready() -> void:
	health = startingHealth
	gold = startingGold
	selectedTowerIndex = 0


func _unhandled_key_input(event: InputEvent) -> void:
	#Temp ui code for debugging
	if Input.is_key_pressed(KEY_1):
		selectedTowerIndex = 0
	if Input.is_key_pressed(KEY_2):
		selectedTowerIndex = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if towerManager.towers.size() == 0: 
		print("No towers in the towerManager")
		return
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_pos) * 100
	ray_cast_3d.force_raycast_update()
	if !ray_cast_3d.is_colliding():
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		return
	var collider = ray_cast_3d.get_collider()
	if !collider is GridMap:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		return
	var collision_point = ray_cast_3d.get_collision_point()
	var cell = GetCellAtPosition(collision_point)
	var selectedTower = towerManager.towers[selectedTowerIndex]
	if gridmap.get_cell_item(cell) == selectedTower.TileType:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if Input.is_action_just_pressed("left_click"):
			if gold >= selectedTower.Cost:
				towerManager.BuildTower(selectedTowerIndex,GetCellLocalPosition(cell))
				gold -= selectedTower.Cost
				SetCellState(cell,TileType.Leaves)
	else: Input.set_default_cursor_shape(Input.CURSOR_FORBIDDEN)



func GetCellAtPosition(pos:Vector3) -> Vector3i:
	return gridmap.local_to_map(pos)
	
func GetCellLocalPosition(pos:Vector3i) -> Vector3:
	return gridmap.map_to_local(pos)

func SetCellState(cell:Vector3i,state:TileType) -> void:
	gridmap.set_cell_item(cell,state) 
