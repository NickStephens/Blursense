from SimpleXMLRPCServer import SimpleXMLRPCServer
import xmlrpclib


def sum(x):
	return x * 2


server = SimpleXMLRPCServer(("localhost", 8001))
print "Listening on localhost:8000 ..."
server.register_function(sum, "sum")


server.serve_forever()
