from BlurClient import BlurClient


class PressureRequest (BlurClient):
	def get (self, params):
		return getattr ( getattr ( self.mRPCClient, 'PressureSensor'), 'pressure' ) ()
