extends Control


func _physics_process(_delta):
	$Health.text = "Health: 20 / " + str(Global.stats["health"])
	$Room.text = "Room: " + str(Global.room)
	$Attack.text = "Attack: 20 / " + str(Global.stats["attack"])
	$Defense.text = "Defense: 12 / " + str(Global.stats["defense"])
	$Level.text = "Level: " + str(Global.level)
