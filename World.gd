extends Node2D

onready var hud = $UILayer/HUD
onready var enemy_spawner = $EnemySpawner
onready var ui_layer = $UILayer
onready var explosion = $EffectsLayer/Explosion

var score = 0

var GameOver = preload("res://ui/GameOverMenu.tscn")

func _ready():
	update_score_and_hud(score)
	hud.update_lives(3)

func _on_Player_spawn_laser(PlayerLaser, location):
	var player_laser = PlayerLaser.instance()
	add_child(player_laser)
	player_laser.position = location


func _on_ShootingEnemy_spawn_laser(EnemyLaser, location):
	var enemy_laser = EnemyLaser.instance()
	add_child(enemy_laser)
	enemy_laser.position = location


func _on_EnemySpawner_spawn_enemy(EnemyScene, location):
	var enemy = EnemyScene.instance()
	add_child(enemy)
	enemy.position = location
	if enemy.has_signal("spawn_laser"):
		enemy.connect("spawn_laser", self, "_on_ShootingEnemy_spawn_laser")
	enemy.connect("enemy_died", self, "_on_enemy_died")

func _on_DeadZone_area_entered(area):
	area.queue_free()
	
func _on_enemy_died(_score, location):
	create_explosion(location)
	update_score_and_hud(_score)

func update_score_and_hud(val):
	score += val
	hud.update_score(score)

func _on_Player_player_took_damage(hp_left):
	hud.update_lives(hp_left)


func _on_Player_player_died(location):
	# Player is dead. Rund game over logic
	create_explosion(location)
	game_over()

func game_over():
	enemy_spawner.stop()
	
	var timer = get_tree().create_timer(2)
	yield(timer, "timeout")
	
	var game_over_menu = GameOver.instance()
	ui_layer.add_child(game_over_menu)
	game_over_menu.set_score(score)

func create_explosion(location):
	explosion.position = location
	explosion.start()
