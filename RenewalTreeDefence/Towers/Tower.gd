class_name Tower extends Node3D

var damage:int = 1
@onready var tower_spawn_sfx: AudioStreamPlayer = $TowerSpawnSFX
@onready var attack_timer: Timer = $AttackTimer

func _ready() -> void:
	if tower_spawn_sfx:
		tower_spawn_sfx.play()

func Attack()-> void:
	pass

