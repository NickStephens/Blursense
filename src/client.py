import xmlrpclib

proxy = xmlrpclib.ServerProxy("http://127.0.0.1:63090")
print proxy.request("battery", "1")
