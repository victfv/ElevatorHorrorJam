extends RigidBody3D

class_name DynamicObject

func on_interacted(state : bool, player : Player) -> Node3D:
	if state:
		player.grabber.grab(self)
		return self
	else:
		player.grabber.release(self)
		return null
