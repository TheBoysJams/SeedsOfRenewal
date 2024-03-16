extends PanelContainer

@export var plant_texture: Texture2D
@export var plant_name: String
@export var plant_cost: int
@export var plant_model: PackedScene
@export var rotation_speed: float = 0.5
@export_range(0,1, 0.05) var model_scale: float = 1.0

@onready var sub_viewport: SubViewport = %SubViewport
@onready var texture_rect: TextureRect = %TextureRect
@onready var name_label = %NameLabel
@onready var cost_label = %CostLabel
@onready var plant_view: Node3D = %PlantView

var mesh: MeshInstance3D


func _ready():
	sub_viewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	texture_rect.texture = sub_viewport.get_texture()
	
	var plant_scene = plant_model.instantiate()
	plant_view.add_child(plant_scene)
	mesh = plant_scene.get_child(0)
	mesh.scale = Vector3(model_scale, model_scale, model_scale)
	
	name_label.text = plant_name
	cost_label.text = "Cost: " + str(plant_cost)
	

func _physics_process(delta: float) -> void:
	mesh.rotation.y += PI * delta * rotation_speed
