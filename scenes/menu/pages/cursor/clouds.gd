extends ParallaxLayer


func _process(delta):
	if(motion_offset.x>-2048):
		motion_offset.x -= 32*delta
	else:
		motion_offset.x=0
	
