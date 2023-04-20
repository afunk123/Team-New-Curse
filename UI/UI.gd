extends Control


func _physics_process(_delta):
	$Health.text = 'Health: ' + str(Global.stats["health"]) +' / '+  str(Global.stats["max_health"])
	$Room.text = "Room: " + str(Global.room)
	$Attack.text = 'Attack: ' + str(Global.stats["attack"]) +' / '+  str(Global.stats["base_attack"])
	$Defense.text = 'Defense: ' + str(Global.stats["defense"]) + ' / '+ str(Global.stats["base_defense"])
	$Level.text = "Level: " + str(Global.level)
