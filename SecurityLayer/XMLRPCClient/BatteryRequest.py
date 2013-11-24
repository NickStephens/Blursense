from BlurClient import BlurClient


class BatteryRequest (BlurClient):
	def get ( self, params ):
		return getattr ( getattr ( self.mRPCClient, 'BatterySensor' ), 'level' ) ()
