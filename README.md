Blursense
=========

The Project
-----------
See [this paper](http://isis.poly.edu/~jcappos/papers/cappos_blursense_sas_14.pdf) for a thorough description of Blursense.

Currently
---------

At this point in time blursense is only made up of an XMLRPC implemented
in the `repy` sandbox. The server uses `repy` 2 to listen for sensor requests.
Once a request has been made, the server will determine how it wants to serve
back the data. This could range from slightly modifying the actual sensor's
data to returning nothing to returning the original data.

Testing
-------

NOTE: These instructions will only work on \*nix systems!

0. Install 'Seattle Testbed' from the Google Play Store onto your android device.

1. Download the [sensibility testbed](https://sensibilitytestbed.com/projects/project/wiki/demo) on an Android device. The link should lead you through the installation process and should provide you with some methods of playing with the testbed. Once you've got your fill remain in your `seash` session for the following steps.


2. Clone this repository into your `seattle-demokit` directory.

	```
	seattle_demokit$ git clone git@github.com:nickstephens/Blursense.git
	```

3. Now back in your `seash` upload the following repy scripts to your android device (the prompt has been omitted for copy-and-paste convenience).

    ```
	upload Blursense/src/battery.repy
	upload Blursense/src/blurserver.repy
	upload Blursense/src/sampleblur.repy
	upload waitforconn.repy
	upload xmlparse.repy
	upload xmlrpc_server_custom.repy
	upload xmlrpc_server.repy
	upload xmlrpc_common.repy
	upload base64.repy
	upload urllib.repy
    upload sensibility/sensorutil.repy
    ```

4. Start the server!

    ```
    example@%1 !> startv2 dylink.repy sampleblur.repy
    ```

5. To test the server we'll have to get onto the device. Hook up your android device and `cd` into the `Blursense/testing`.

6. Push both the files in this directory onto the android device using `adb`.
	
	```
	testing$ adb push * /data/local/tmp
	```

7. Launch a shell onto the device and `cd` into `/data/local/tmp`.

	```
	testing$ adb shell
	shell@android $ cd /data/local/tmp
	```

8. Source exports.sh to setup your shell's environment.

	```
	shell@android:data/local/tmp $ . ./exports.sh
	```

9. Read off the port the XMLRPC server bound to with `show log` in your `seash` session. Next run `democlient.py` with that port as an argument.

	```
	shell@android:data/local/tmp $ python democlient.py <port>
	```

10. Appreciate your current battery health.
