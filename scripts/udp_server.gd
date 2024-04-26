class_name ServerNode
extends Node

var server := UDPServer.new()
var peers = []
var cameraTexture:TextureRect

func _ready():
	server.listen(4242)

func _process(delta):
	server.poll() # Important!
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		# Reply so it knows we received the message.		
		# peer.put_packet(packet)
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)

	for i in range(0, peers.size()):
		var peerPacket=peers[i].get_packet()
		#TODO verify type of data that arrives
		if cameraTexture != null && peerPacket.size()!=0:
			# Assign the texture to the TextureRect
			cameraTexture.texture = create_texture_from_pool_byte_array(peerPacket)
			#print(peerPacket)


func set_cameraTexture(textureRect:TextureRect):
	cameraTexture=textureRect

func create_texture_from_pool_byte_array(byte_array):
	var image = Image.new()
	image.load_jpg_from_buffer(byte_array) 
	var imageTexture = ImageTexture.create_from_image(image)
	return imageTexture

func send_array(message):
	for i in range(0, peers.size()):
		peers[i].put_packet(PackedByteArray(message))

func send_string(message:String):
	for i in range(0, peers.size()):
		peers[i].put_packet(message.to_utf8_buffer())
	
