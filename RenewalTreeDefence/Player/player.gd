extends Node3D
class_name Player 

@onready var ray_cast_3d: RayCast3D = $Camera/RayCast3D
@onready var camera: Camera3D = $Camera

@export var cameraDistance:= 10.0
@export var cameraYRot:= 90.0
@export var gridmap: GridMap
@export var towerManager: TowerManager
@export var goldToWin:= 20
@export var startingGold = 10
@export var startingHealth = 5

signal HealthChanged(int)
signal GoldChanged(int)
signal SelectedTowerChanged(TowerInfo)
signal Defated()
signal OnLoaded(int)
signal CursorChanged(CursorShape)

var health:int:
	set(hp_in):
		health = hp_in
		HealthChanged.emit(health)
		if(health) == 0:
			Defated.emit()

var selectedTowerIndex:int:
	set(index_in):
		selectedTowerIndex = wrapi(index_in,0,towerManager.towers.size()) 
		SelectedTowerChanged.emit(towerManager.towers[selectedTowerIndex])

var gold:int:
	set(gold_in):
		gold = max(gold_in,0)
		GoldChanged.emit(gold)

enum TileType {
	Dirt = 0,
	Grass = 1,
	Leaves = 2,
	GrassUsed = 3
}

func _ready() -> void:
	UpdateCameraZoom()
	rotation_degrees.y = cameraYRot
	health = startingHealth
	gold = startingGold
	selectedTowerIndex = 0
	OnLoaded.emit(goldToWin)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Plant1"):
		selectedTowerIndex = 0
	if Input.is_action_just_pressed("Plant2"):
		selectedTowerIndex = 1
	if Input.is_action_pressed("RotateRight"):
		rotation_degrees.y += 5
	if Input.is_action_pressed("RotateLeft"):
		rotation_degrees.y -= 5
	if Input.is_action_pressed("ZoomIn"):
		cameraDistance -= 2
		UpdateCameraZoom()
	if Input.is_action_pressed("ZoomOut"):
		cameraDistance += 2
		UpdateCameraZoom()
	if Input.is_action_pressed("NextPlant"):
		selectedTowerIndex += 1
	if Input.is_action_pressed("PreviousPlant"):
		selectedTowerIndex -= 1

func UpdateCameraZoom()-> void:
	cameraDistance = clampf(cameraDistance,5,60)
	camera.position.z = cameraDistance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if towerManager.towers.size() == 0: 
		print("No towers in the towerManager")
		return
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = camera.project_local_ray_normal(mouse_pos) * 1000
	ray_cast_3d.force_raycast_update()
	if !ray_cast_3d.is_colliding():
		CursorChanged.emit(Control.CURSOR_ARROW)
		return
	var collider = ray_cast_3d.get_collider()
	if !collider is GridMap:
		CursorChanged.emit(Control.CURSOR_ARROW)
		return
	var collision_point = ray_cast_3d.get_collision_point()
	var cell = GetCellAtPosition(collision_point)
	var selectedTower = towerManager.towers[selectedTowerIndex]
	if gridmap.get_cell_item(cell) == selectedTower.TileType:
		CursorChanged.emit(Control.CURSOR_POINTING_HAND)
		if Input.is_action_just_pressed("left_click"):
			if gold >= selectedTower.Cost:
				towerManager.BuildTower(selectedTowerIndex,GetCellLocalPosition(cell))
				gold -= selectedTower.Cost
				SetCellState(cell,selectedTower.BuiltTileType)
	else:	
		CursorChanged.emit(Control.CURSOR_FORBIDDEN)

func GetCellAtPosition(pos:Vector3) -> Vector3i:
	return gridmap.local_to_map(pos)
	
func GetCellLocalPosition(pos:Vector3i) -> Vector3:
	return gridmap.map_to_local(pos)

func SetCellState(cell:Vector3i,state:TileType) -> void:
	gridmap.set_cell_item(cell,state)
