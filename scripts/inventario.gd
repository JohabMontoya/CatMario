extends Area2D



func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area is Item:
		Inventory.add_item_to_inventory(area)
		area.collect_item()
