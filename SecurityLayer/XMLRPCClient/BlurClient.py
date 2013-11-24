import xmlrpclib
import errno
import socket


# Ports used by Sensorium
SEATTLE_PORTS = [63090, 63091, 63092, 63093, 63094, 63095, 63096, 63097, 63098, 63099]
LOCALHOST = '127.0.0.1'


class BlurClient:
	def __init__(self, addr = LOCALHOST, ports = SEATTLE_PORTS):
		self.mAddr = addr
		self.mPorts = ports
		if len( self.mPorts ) < 1:
			self.mPorts = SEATTLE_PORTS

		# Use 1st Port Initially
		self.mPort = 0

		# Initialize XMLRPC Client
		self.mRPCClient = xmlrpclib.Server('http://%s:%s' % ( self.mAddr, self.mPorts[self.mPort]) )


	# Overriden by Subclasses
	def get(self, params):
		return None
				

	def request(self, params = 0):
		while True:
			try:
				return self.get(params)	

			except socket.error as e:
				# Check for Connection Refused Error
				if e[0] == errno.ECONNREFUSED:
					if self.mPort >= len( self.mPorts ):
						raise Exception( 'Connection Refused' )
					else:
						self.mPort = self.mPort + 1
						self.mRPCClient = xmlrpclib.Server('http://%s:%s' % ( self.mAddr, self.mPorts[self.mPort]) )
				else:
					raise e
					
		


	
