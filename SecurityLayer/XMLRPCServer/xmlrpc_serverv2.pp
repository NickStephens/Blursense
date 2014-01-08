'''
This needs to  work with RepyV2
look in repy_v2/seattlelib/xmlrpc_server.repy

for installing RepyV2, 
created /sdcard/sl4a/seattle/seattle_repy_v2/

<Program Name>
  xmlrpc_server2.repy

<Started>
  Dec 2013

<Author>
  Richard Weiss based on xml_rpc_server.repy

<Purpose>
  Provide a usable XML-RPC server for RePy V2 code and blursense.
'''

#include xmlparse.repy
#include xmlrpc_common.repy
include repy_vs/seattlelib/urllib.repy


def battery():
    return 0.70


def my_xmlrpc_server():
    for sensorport in [63090, 63096, 63097, 63098, 63099, 63095, 63091, 63092, 63093, 63094]:
      try:
	server = xmlrpc_server_SimpleXMLRPCServer(("localhost", sensorport))
      except socket.error:
    	print 'port:', sensorport, 'failed.   Trying backup port...' 
        continue
      log( "*** Connected to port", sensorport)
      break
      else:
	log( 'Could not locate a port!')
    	exitall()

    #server.register_function(battery)
    #server.serve_forever()

my_xmlrpc_server()


'''
  # Collect device vendor/name/tac once, and radio mcc/mnc/cid/nwtype/rssi, 
  # gps data, and network location (in case gps fails) regularly.

  vendor = s.send_request("DeviceInfoSensor.vendorname", ())
  model = s.send_request("DeviceInfoSensor.modelname", ())
  tac = s.send_request("DeviceInfoSensor.tac", ())
  print "*** This is a", model, "by", vendor, "with TAC", tac

  results_file = open("o3gm_readings.txt", "a")

  gps_last_timestamp = 0L

  while True:
    try:
      # Back off if we're running low on battery
      BATTERY_LOW_LEVEL = 15
      battery_level = s.send_request("BatterySensor.level", ())
      while battery_level < BATTERY_LOW_LEVEL:
        pause = (BATTERY_LOW_LEVL - battery_level) * 120
        print "*** We've been draining the battery. Let's sleep", pause, "seconds."
        sleep(pause)
        battery_level = s.send_request("BatterySensor.level", ())

      mcc = s.send_request("RadioSensor.mcc", ())
      mnc = s.send_request("RadioSensor.mnc", ())
      cell_id = s.send_request("RadioSensor.cid", ())
      nw_type = s.send_request("RadioSensor.networktype", ())
      rssi = s.send_request("RadioSensor.signalstrength", ())

      gps_timestamp = s.send_request("GPSLocationSensor.timestamp", ())
      if gps_last_timestamp == gps_timestamp:
        # This GPS datum is stale. Let's use NW locations instead...
        loc_source = "network"
        timestamp = s.send_request("RadioSensor.timestamp", ())
        lat = s.send_request("NetworkLocationSensor.latitude", ())
        lon = s.send_request("NetworkLocationSensor.longitude", ())
        alt = -99999.
        accuracy = s.send_request("NetworkLocationSensor.accuracy", ())
      else: # We have current GPS data
        loc_source = "GPS"
        timestamp = gps_last_timestamp = gps_timestamp
        lat = s.send_request("GPSLocationSensor.latitude", ())
        lon = s.send_request("GPSLocationSensor.longitude", ())
        alt = s.send_request("GPSLocationSensor.altitude", ())
        accuracy = s.send_request("GPSLocationSensor.accuracy", ())

      print getruntime(), timestamp, mcc, mnc, cell_id, nw_type, rssi, loc_source, lat, lon, alt, accuracy, battery_level, tac, vendor, model
      print >>results_file, getruntime(), timestamp, mcc, mnc, cell_id, nw_type, rssi, loc_source, lat, lon, alt, accuracy, battery_level, tac, vendor, model
      results_file.flush()

    except Exception, e:
      print "*** Oops,", str(e)
      pause = 15
      print "*** Sleeping", pause, "seconds, will continue..."
      sleep(pause)
'''
