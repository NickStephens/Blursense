import sys
import xmlrpclib

def main(argc, argv):
	
	if (argc != 2):
		print ("usage: %s <XMLRPC-server-port>" % argv[0])
		sys.exit(1)

	port   = int(argv[1])
	proxy  = xmlrpclib.ServerProxy("http://localhost:" + str(port))
	result = proxy.request("battery", "1")

	print "="*40
	print "Returned " + str(result)
	print "="*40

if __name__ == "__main__":
	main(len(sys.argv), sys.argv)
