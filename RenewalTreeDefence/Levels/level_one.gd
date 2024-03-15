extends Node3D

@onready var player: Player = $Player

@export var goldEarnedToWin:= 20
var goldEarned:= 0

signal OnLoaded(String)

func _ready() -> void:
	OnLoaded.emit("Have " + str(goldEarnedToWin) + " gold to beat the level.")

func _on_player_gold_changed(gold:int) -> void:
		if gold >= goldEarnedToWin:
			player.Victory.emit()
