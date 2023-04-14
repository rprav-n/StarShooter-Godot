extends Area2D

signal enemy_died(score, location)

export (int) var speed = 150
export (int) var hp = 1
export (int) var damage = 1
export (int) var score = 10

onready var hitSound = $HitSound

func _process(delta):
	position.y += speed * delta

func _on_Enemy_area_entered(area):
	if area is Player:
		take_damage(damage)

func take_damage(_damage):
	hp -= _damage
	hitSound.play()
	if hp <= 0:
		queue_free()
		emit_signal("enemy_died", score, position)
