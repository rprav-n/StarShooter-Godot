extends Area2D

export (int) var speed = 1000
export (int, -1, 1) var vertical_direction = 1 # 1 for Enemy or -1 for Player
export (int) var damage = 1

func _process(delta):
	position.y += speed * vertical_direction * delta
