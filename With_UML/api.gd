extends Node

signal response(data)
signal not_working(msg)

func request_get(road : String) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_get_completed)
	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(Global.url + road)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		not_working.emit("An error occurred in the HTTP request.")
	

func _on_request_get_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	response.emit(data)
