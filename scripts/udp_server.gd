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
		peer.put_packet(packet)
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)

	for i in range(0, peers.size()):
		var peerPacket=peers[i].get_packet()
		if cameraTexture != null && peerPacket.size()!=0:
			# Assign the texture to the TextureRect
			print("llegue",peerPacket.size())
			cameraTexture.texture = create_texture_from_pool_byte_array(peerPacket)


func set_cameraTexture(textureRect:TextureRect):
	cameraTexture=textureRect

func create_texture_from_pool_byte_array(byte_array):
	var im = Image.new()
	im.load_jpg_from_buffer(byte_array) 
	var im_tx = ImageTexture.new()
	im_tx.create_from_image(im)
	return im_tx
