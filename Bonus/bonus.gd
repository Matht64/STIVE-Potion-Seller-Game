extends Resource

class_name Bonus

@export var id : int
@export var type : String
@export var duration : int
@export var activated_time : String

func _init(_id: int = -1, _type: String = "", _duration: int = -1, _activated_time : String = "") -> void:
	self.id = _id
	self.type = _type
	self.duration = _duration
	self.activated_time = _activated_time
