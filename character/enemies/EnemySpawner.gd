extends Node2D

signal spawn_enemy(EnemyScene, location)

export (Array, PackedScene) var enemies 

onready var spawn_timer = $SpawnTimer

var spawn_positions = null

func _ready():
	randomize()
	spawn_positions = $SpawnPositions.get_children()

func _on_SpawnTimer_timeout():
	spawn_random_enemy()

func spawn_random_enemy():
	var rand_enemy = enemies[randi()%enemies.size()]
	var rand_position = spawn_positions[randi()%spawn_positions.size()]
	emit_signal("spawn_enemy", rand_enemy, rand_position.global_position)

func stop():
	spawn_timer.stop()
