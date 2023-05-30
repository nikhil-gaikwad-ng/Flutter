// // import 'package:flutter/material.dart';

// // /**network_info_plus */
// // // import 'package:network_info_plus/network_info_plus.dart';

// // // import 'package:connectivity_plus/connectivity_plus.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});
// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: OutlinedButton(
// //             onPressed: () async {
// //               /************************network_info_plu*******************/
// //               // final info = NetworkInfo();
// //               // final wifiName = await info.getWifiName(); // "FooNetwork"
// //               // final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
// //               // final wifiIP = await info.getWifiIP(); // 192.168.1.43
// //               // final wifiIPv6 = await info
// //               //     .getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
// //               // final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
// //               // final wifiBroadcast =
// //               //     await info.getWifiBroadcast(); // 192.168.1.255
// //               // final wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1
// //               // print(wifiName);
// //               // print(wifiBSSID);
// //               // print(wifiIP);
// //               // print(wifiIPv6);
// //               // print(wifiSubmask);
// //               // print(wifiBroadcast);
// //               // print(wifiGateway);

// //               // ****************************************************************************************/

// //               // final connectivityResult =
// //               //     await (Connectivity().checkConnectivity());
// //               // if (connectivityResult == ConnectivityResult.mobile) {
// //               //   // I am connected to a mobile network.
// //               // } else if (connectivityResult == ConnectivityResult.wifi) {
// //               //   // I am connected to a wifi network.
// //               // } else if (connectivityResult == ConnectivityResult.ethernet) {
// //               //   // I am connected to a ethernet network.
// //               // } else if (connectivityResult == ConnectivityResult.vpn) {
// //               //   // I am connected to a vpn network.
// //               //   // Note for iOS and macOS:
// //               //   // There is no separate network interface type for [vpn].
// //               //   // It returns [other] on any device (also simulator)
// //               // } else if (connectivityResult == ConnectivityResult.bluetooth) {
// //               //   // I am connected to a bluetooth.
// //               // } else if (connectivityResult == ConnectivityResult.other) {
// //               //   // I am connected to a network which is not in the above mentioned networks.
// //               // } else if (connectivityResult == ConnectivityResult.none) {
// //               //   // I am not connected to any network.
// //               // }
// //             },
// //             child: Text("Click")),
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: deprecated_member_use, package_api_docs, public_member_api_docs
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:wifi_iot/wifi_iot.dart';
// import 'dart:io' show Platform;

// const String STA_DEFAULT_SSID = "STA_SSID";
// const String STA_DEFAULT_PASSWORD = "STA_PASSWORD";
// const NetworkSecurity STA_DEFAULT_SECURITY = NetworkSecurity.WPA;

// const String AP_DEFAULT_SSID = "AP_SSID";
// const String AP_DEFAULT_PASSWORD = "AP_PASSWORD";

// void main() => runApp(FlutterWifiIoT());

// class FlutterWifiIoT extends StatefulWidget {
//   @override
//   _FlutterWifiIoTState createState() => _FlutterWifiIoTState();
// }

// class _FlutterWifiIoTState extends State<FlutterWifiIoT> {
//   String? _sPreviousAPSSID = "";
//   String? _sPreviousPreSharedKey = "";

//   List<WifiNetwork?>? _htResultNetwork;
//   Map<String, bool>? _htIsNetworkRegistered = Map();

//   bool _isEnabled = false;
//   bool _isConnected = false;
//   bool _isWiFiAPEnabled = false;
//   bool _isWiFiAPSSIDHidden = false;
//   bool _isWifiAPSupported = true;
//   bool _isWifiEnableOpenSettings = false;
//   bool _isWifiDisableOpenSettings = false;

//   final TextStyle textStyle = TextStyle(color: Colors.white);

//   @override
//   initState() {
//     WiFiForIoTPlugin.isEnabled().then((val) {
//       _isEnabled = val;
//     });

//     WiFiForIoTPlugin.isConnected().then((val) {
//       _isConnected = val;
//     });

//     WiFiForIoTPlugin.isWiFiAPEnabled().then((val) {
//       _isWiFiAPEnabled = val;
//     }).catchError((val) {
//       _isWifiAPSupported = false;
//     });

//     super.initState();
//   }

//   storeAndConnect(String psSSID, String psKey) async {
//     await storeAPInfos();
//     await WiFiForIoTPlugin.setWiFiAPSSID(psSSID);
//     await WiFiForIoTPlugin.setWiFiAPPreSharedKey(psKey);
//   }

//   storeAPInfos() async {
//     String? sAPSSID;
//     String? sPreSharedKey;

//     try {
//       sAPSSID = await WiFiForIoTPlugin.getWiFiAPSSID();
//     } on PlatformException {
//       sAPSSID = "";
//     }

//     try {
//       sPreSharedKey = await WiFiForIoTPlugin.getWiFiAPPreSharedKey();
//     } on PlatformException {
//       sPreSharedKey = "";
//     }

//     setState(() {
//       _sPreviousAPSSID = sAPSSID;
//       _sPreviousPreSharedKey = sPreSharedKey;
//     });
//   }

//   restoreAPInfos() async {
//     WiFiForIoTPlugin.setWiFiAPSSID(_sPreviousAPSSID!);
//     WiFiForIoTPlugin.setWiFiAPPreSharedKey(_sPreviousPreSharedKey!);
//   }

//   // [sAPSSID, sPreSharedKey]
//   Future<List<String>> getWiFiAPInfos() async {
//     String? sAPSSID;
//     String? sPreSharedKey;

//     try {
//       sAPSSID = await WiFiForIoTPlugin.getWiFiAPSSID();
//     } on Exception {
//       sAPSSID = "";
//     }

//     try {
//       sPreSharedKey = await WiFiForIoTPlugin.getWiFiAPPreSharedKey();
//     } on Exception {
//       sPreSharedKey = "";
//     }

//     return [sAPSSID!, sPreSharedKey!];
//   }

//   Future<WIFI_AP_STATE?> getWiFiAPState() async {
//     int? iWiFiState;

//     WIFI_AP_STATE? wifiAPState;

//     try {
//       iWiFiState = await WiFiForIoTPlugin.getWiFiAPState();
//     } on Exception {
//       iWiFiState = WIFI_AP_STATE.WIFI_AP_STATE_FAILED.index;
//     }

//     if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_DISABLING.index) {
//       wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_DISABLING;
//     } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_DISABLED.index) {
//       wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_DISABLED;
//     } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_ENABLING.index) {
//       wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_ENABLING;
//     } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_ENABLED.index) {
//       wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_ENABLED;
//     } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_FAILED.index) {
//       wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_FAILED;
//     }

//     return wifiAPState!;
//   }

//   Future<List<APClient>> getClientList(
//       bool onlyReachables, int reachableTimeout) async {
//     List<APClient> htResultClient;

//     try {
//       htResultClient = await WiFiForIoTPlugin.getClientList(
//           onlyReachables, reachableTimeout);
//     } on PlatformException {
//       htResultClient = <APClient>[];
//     }

//     return htResultClient;
//   }

//   Future<List<WifiNetwork>> loadWifiList() async {
//     List<WifiNetwork> htResultNetwork;
//     try {
//       htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
//     } on PlatformException {
//       htResultNetwork = <WifiNetwork>[];
//     }

//     return htResultNetwork;
//   }

//   isRegisteredWifiNetwork(String ssid) async {
//     bool bIsRegistered;

//     try {
//       bIsRegistered = await WiFiForIoTPlugin.isRegisteredWifiNetwork(ssid);
//     } on PlatformException {
//       bIsRegistered = false;
//     }

//     setState(() {
//       _htIsNetworkRegistered![ssid] = bIsRegistered;
//     });
//   }

//   void showClientList() async {
//     /// Refresh the list and show in console
//     getClientList(false, 300).then((val) => val.forEach((oClient) {
//           print("************************");
//           print("Client :");
//           print("ipAddr = '${oClient.ipAddr}'");
//           print("hwAddr = '${oClient.hwAddr}'");
//           print("device = '${oClient.device}'");
//           print("isReachable = '${oClient.isReachable}'");
//           print("************************");
//         }));
//   }

//   Widget getWidgets() {
//     WiFiForIoTPlugin.isConnected().then((val) {
//       setState(() {
//         _isConnected = val;
//       });
//     });

//     // disable scanning for ios as not supported
//     if (_isConnected || Platform.isIOS) {
//       _htResultNetwork = null;
//     }

//     if (_htResultNetwork != null && _htResultNetwork!.length > 0) {
//       final List<ListTile> htNetworks = <ListTile>[];

//       _htResultNetwork!.forEach((oNetwork) {
//         final PopupCommand oCmdConnect =
//             PopupCommand("Connect", oNetwork!.ssid!);
//         final PopupCommand oCmdRemove = PopupCommand("Remove", oNetwork.ssid!);

//         final List<PopupMenuItem<PopupCommand>> htPopupMenuItems = [];

//         htPopupMenuItems.add(
//           PopupMenuItem<PopupCommand>(
//             value: oCmdConnect,
//             child: const Text('Connect'),
//           ),
//         );

//         setState(() {
//           isRegisteredWifiNetwork(oNetwork.ssid!);
//           if (_htIsNetworkRegistered!.containsKey(oNetwork.ssid) &&
//               _htIsNetworkRegistered![oNetwork.ssid]!) {
//             htPopupMenuItems.add(
//               PopupMenuItem<PopupCommand>(
//                 value: oCmdRemove,
//                 child: const Text('Remove'),
//               ),
//             );
//           }

//           htNetworks.add(
//             ListTile(
//               title: Text("" +
//                   oNetwork.ssid! +
//                   ((_htIsNetworkRegistered!.containsKey(oNetwork.ssid) &&
//                           _htIsNetworkRegistered![oNetwork.ssid]!)
//                       ? " *"
//                       : "")),
//               trailing: PopupMenuButton<PopupCommand>(
//                 padding: EdgeInsets.zero,
//                 onSelected: (PopupCommand poCommand) {
//                   switch (poCommand.command) {
//                     case "Connect":
//                       WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
//                           password: STA_DEFAULT_PASSWORD,
//                           joinOnce: true,
//                           security: STA_DEFAULT_SECURITY);
//                       break;
//                     case "Remove":
//                       WiFiForIoTPlugin.removeWifiNetwork(poCommand.argument);
//                       break;
//                     default:
//                       break;
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => htPopupMenuItems,
//               ),
//             ),
//           );
//         });
//       });

//       return ListView(
//         padding: kMaterialListPadding,
//         children: htNetworks,
//       );
//     } else {
//       return SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: Platform.isIOS
//                 ? getButtonWidgetsForiOS()
//                 : getButtonWidgetsForAndroid(),
//           ),
//         ),
//       );
//     }
//   }

//   List<Widget> getButtonWidgetsForAndroid() {
//     final List<Widget> htPrimaryWidgets = <Widget>[];

//     WiFiForIoTPlugin.isEnabled().then((val) {
//       setState(() {
//         _isEnabled = val;
//       });
//     });

//     if (_isEnabled) {
//       htPrimaryWidgets.addAll([
//         SizedBox(height: 10),
//         Text("Wifi Enabled"),
//         MaterialButton(
//           color: Colors.blue,
//           child: Text("Disable", style: textStyle),
//           onPressed: () {
//             WiFiForIoTPlugin.setEnabled(false,
//                 shouldOpenSettings: _isWifiDisableOpenSettings);
//           },
//         ),
//       ]);

//       WiFiForIoTPlugin.isConnected().then((val) {
//         setState(() {
//           _isConnected = val;
//         });
//       });

//       if (_isConnected) {
//         htPrimaryWidgets.addAll(<Widget>[
//           Text("Connected"),
//           FutureBuilder(
//               future: WiFiForIoTPlugin.getSSID(),
//               initialData: "Loading..",
//               builder: (BuildContext context, AsyncSnapshot<String?> ssid) {
//                 return Text("SSID: ${ssid.data}");
//               }),
//           FutureBuilder(
//               future: WiFiForIoTPlugin.getBSSID(),
//               initialData: "Loading..",
//               builder: (BuildContext context, AsyncSnapshot<String?> bssid) {
//                 return Text("BSSID: ${bssid.data}");
//               }),
//           FutureBuilder(
//               future: WiFiForIoTPlugin.getCurrentSignalStrength(),
//               initialData: 0,
//               builder: (BuildContext context, AsyncSnapshot<int?> signal) {
//                 return Text("Signal: ${signal.data}");
//               }),
//           FutureBuilder(
//               future: WiFiForIoTPlugin.getFrequency(),
//               initialData: 0,
//               builder: (BuildContext context, AsyncSnapshot<int?> freq) {
//                 return Text("Frequency : ${freq.data}");
//               }),
//           FutureBuilder(
//               future: WiFiForIoTPlugin.getIP(),
//               initialData: "Loading..",
//               builder: (BuildContext context, AsyncSnapshot<String?> ip) {
//                 return Text("IP : ${ip.data}");
//               }),
//           MaterialButton(
//             color: Colors.blue,
//             child: Text("Disconnect", style: textStyle),
//             onPressed: () {
//               WiFiForIoTPlugin.disconnect();
//             },
//           ),
//           CheckboxListTile(
//               title: const Text("Disable WiFi on settings"),
//               subtitle: const Text("Available only on android API level >= 29"),
//               value: _isWifiDisableOpenSettings,
//               onChanged: (bool? setting) {
//                 if (setting != null) {
//                   setState(() {
//                     _isWifiDisableOpenSettings = setting;
//                   });
//                 }
//               })
//         ]);
//       } else {
//         htPrimaryWidgets.addAll(<Widget>[
//           Text("Disconnected"),
//           MaterialButton(
//             color: Colors.blue,
//             child: Text("Scan", style: textStyle),
//             onPressed: () async {
//               _htResultNetwork = await loadWifiList();
//               setState(() {});
//             },
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               MaterialButton(
//                 color: Colors.blue,
//                 child: Text("Use WiFi", style: textStyle),
//                 onPressed: () {
//                   WiFiForIoTPlugin.forceWifiUsage(true);
//                 },
//               ),
//               SizedBox(width: 50),
//               MaterialButton(
//                 color: Colors.blue,
//                 child: Text("Use 3G/4G", style: textStyle),
//                 onPressed: () {
//                   WiFiForIoTPlugin.forceWifiUsage(false);
//                 },
//               ),
//             ],
//           ),
//           CheckboxListTile(
//               title: const Text("Disable WiFi on settings"),
//               subtitle: const Text("Available only on android API level >= 29"),
//               value: _isWifiDisableOpenSettings,
//               onChanged: (bool? setting) {
//                 if (setting != null) {
//                   setState(() {
//                     _isWifiDisableOpenSettings = setting;
//                   });
//                 }
//               })
//         ]);
//       }
//     } else {
//       htPrimaryWidgets.addAll(<Widget>[
//         SizedBox(height: 10),
//         Text("Wifi Disabled"),
//         MaterialButton(
//           color: Colors.blue,
//           child: Text("Enable", style: textStyle),
//           onPressed: () {
//             setState(() {
//               WiFiForIoTPlugin.setEnabled(true,
//                   shouldOpenSettings: _isWifiEnableOpenSettings);
//             });
//           },
//         ),
//         CheckboxListTile(
//             title: const Text("Enable WiFi on settings"),
//             subtitle: const Text("Available only on android API level >= 29"),
//             value: _isWifiEnableOpenSettings,
//             onChanged: (bool? setting) {
//               if (setting != null) {
//                 setState(() {
//                   _isWifiEnableOpenSettings = setting;
//                 });
//               }
//             })
//       ]);
//     }

//     htPrimaryWidgets.add(Divider(
//       height: 32.0,
//     ));

//     if (_isWifiAPSupported) {
//       htPrimaryWidgets.addAll(<Widget>[
//         Text("WiFi AP State"),
//         FutureBuilder(
//             future: getWiFiAPState(),
//             initialData: WIFI_AP_STATE.WIFI_AP_STATE_DISABLED,
//             builder: (BuildContext context,
//                 AsyncSnapshot<WIFI_AP_STATE?> wifiState) {
//               final List<Widget> widgets = [];

//               if (wifiState.data == WIFI_AP_STATE.WIFI_AP_STATE_ENABLED) {
//                 widgets.add(MaterialButton(
//                   color: Colors.blue,
//                   child: Text("Get Client List", style: textStyle),
//                   onPressed: () {
//                     showClientList();
//                   },
//                 ));
//               }

//               widgets.add(Text(wifiState.data.toString()));

//               return Column(children: widgets);
//             }),
//       ]);

//       WiFiForIoTPlugin.isWiFiAPEnabled()
//           .then((val) => setState(() {
//                 _isWiFiAPEnabled = val;
//               }))
//           .catchError((val) {
//         _isWiFiAPEnabled = false;
//       });

//       if (_isWiFiAPEnabled) {
//         htPrimaryWidgets.addAll(<Widget>[
//           Text("Wifi AP Enabled"),
//           MaterialButton(
//             color: Colors.blue,
//             child: Text("Disable", style: textStyle),
//             onPressed: () {
//               WiFiForIoTPlugin.setWiFiAPEnabled(false);
//             },
//           ),
//         ]);
//       } else {
//         htPrimaryWidgets.addAll(<Widget>[
//           Text("Wifi AP Disabled"),
//           MaterialButton(
//             color: Colors.blue,
//             child: Text("Enable", style: textStyle),
//             onPressed: () {
//               WiFiForIoTPlugin.setWiFiAPEnabled(true);
//             },
//           ),
//         ]);
//       }

//       WiFiForIoTPlugin.isWiFiAPSSIDHidden()
//           .then((val) => setState(() {
//                 _isWiFiAPSSIDHidden = val;
//               }))
//           .catchError((val) => _isWiFiAPSSIDHidden = false);
//       if (_isWiFiAPSSIDHidden) {
//         htPrimaryWidgets.add(Text("SSID is hidden"));
//         !_isWiFiAPEnabled
//             ? MaterialButton(
//                 color: Colors.blue,
//                 child: Text("Show", style: textStyle),
//                 onPressed: () {
//                   WiFiForIoTPlugin.setWiFiAPSSIDHidden(false);
//                 },
//               )
//             : Container(width: 0, height: 0);
//       } else {
//         htPrimaryWidgets.add(Text("SSID is visible"));
//         !_isWiFiAPEnabled
//             ? MaterialButton(
//                 color: Colors.blue,
//                 child: Text("Hide", style: textStyle),
//                 onPressed: () {
//                   WiFiForIoTPlugin.setWiFiAPSSIDHidden(true);
//                 },
//               )
//             : Container(width: 0, height: 0);
//       }

//       FutureBuilder(
//           future: getWiFiAPInfos(),
//           initialData: <String>[],
//           builder: (BuildContext context, AsyncSnapshot<List<String>> info) {
//             htPrimaryWidgets.addAll(<Widget>[
//               Text("SSID : ${info.data![0]}"),
//               Text("KEY  : ${info.data![1]}"),
//               MaterialButton(
//                 color: Colors.blue,
//                 child: Text(
//                     "Set AP info ($AP_DEFAULT_SSID/$AP_DEFAULT_PASSWORD)",
//                     style: textStyle),
//                 onPressed: () {
//                   storeAndConnect(AP_DEFAULT_SSID, AP_DEFAULT_PASSWORD);
//                 },
//               ),
//               Text("AP SSID stored : $_sPreviousAPSSID"),
//               Text("KEY stored : $_sPreviousPreSharedKey"),
//               MaterialButton(
//                 color: Colors.blue,
//                 child: Text("Store AP infos", style: textStyle),
//                 onPressed: () {
//                   storeAPInfos();
//                 },
//               ),
//               MaterialButton(
//                 color: Colors.blue,
//                 child: Text("Restore AP infos", style: textStyle),
//                 onPressed: () {
//                   restoreAPInfos();
//                 },
//               ),
//             ]);

//             return Text("SSID : ${info.data![0]}");
//           });
//     } else {
//       htPrimaryWidgets.add(
//           Center(child: Text("Wifi AP probably not supported by your device")));
//     }

//     return htPrimaryWidgets;
//   }

//   List<Widget> getButtonWidgetsForiOS() {
//     final List<Widget> htPrimaryWidgets = <Widget>[];

//     WiFiForIoTPlugin.isEnabled().then((val) => setState(() {
//           _isEnabled = val;
//         }));

//     if (_isEnabled) {
//       htPrimaryWidgets.add(Text("Wifi Enabled"));
//       WiFiForIoTPlugin.isConnected().then((val) => setState(() {
//             _isConnected = val;
//           }));

//       String? _sSSID;

//       if (_isConnected) {
//         htPrimaryWidgets.addAll(<Widget>[
//           Text("Connected"),
//           FutureBuilder(
//               future: WiFiForIoTPlugin.getSSID(),
//               initialData: "Loading..",
//               builder: (BuildContext context, AsyncSnapshot<String?> ssid) {
//                 _sSSID = ssid.data;

//                 return Text("SSID: ${ssid.data}");
//               }),
//         ]);

//         if (_sSSID == STA_DEFAULT_SSID) {
//           htPrimaryWidgets.addAll(<Widget>[
//             MaterialButton(
//               color: Colors.blue,
//               child: Text("Disconnect", style: textStyle),
//               onPressed: () {
//                 WiFiForIoTPlugin.disconnect();
//               },
//             ),
//           ]);
//         } else {
//           htPrimaryWidgets.addAll(<Widget>[
//             MaterialButton(
//               color: Colors.blue,
//               child: Text("Connect to '$AP_DEFAULT_SSID'", style: textStyle),
//               onPressed: () {
//                 WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
//                     password: STA_DEFAULT_PASSWORD,
//                     joinOnce: true,
//                     security: NetworkSecurity.WPA);
//               },
//             ),
//           ]);
//         }
//       } else {
//         htPrimaryWidgets.addAll(<Widget>[
//           Text("Disconnected"),
//           MaterialButton(
//             color: Colors.blue,
//             child: Text("Connect to '$AP_DEFAULT_SSID'", style: textStyle),
//             onPressed: () {
//               WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
//                   password: STA_DEFAULT_PASSWORD,
//                   joinOnce: true,
//                   security: NetworkSecurity.WPA);
//             },
//           ),
//         ]);
//       }
//     } else {
//       htPrimaryWidgets.addAll(<Widget>[
//         Text("Wifi Disabled?"),
//         MaterialButton(
//           color: Colors.blue,
//           child: Text("Connect to '$AP_DEFAULT_SSID'", style: textStyle),
//           onPressed: () {
//             WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
//                 password: STA_DEFAULT_PASSWORD,
//                 joinOnce: true,
//                 security: NetworkSecurity.WPA);
//           },
//         ),
//       ]);
//     }

//     return htPrimaryWidgets;
//   }

//   @override
//   Widget build(BuildContext poContext) {
//     return MaterialApp(
//       title: Platform.isIOS
//           ? "WifiFlutter Example iOS"
//           : "WifiFlutter Example Android",
//       home: Scaffold(
//         appBar: AppBar(
//           title: Platform.isIOS
//               ? Text('WifiFlutter Example iOS')
//               : Text('WifiFlutter Example Android'),
//           actions: _isConnected
//               ? <Widget>[
//                   PopupMenuButton<String>(
//                     onSelected: (value) {
//                       switch (value) {
//                         case "disconnect":
//                           WiFiForIoTPlugin.disconnect();
//                           break;
//                         case "remove":
//                           WiFiForIoTPlugin.getSSID().then((val) =>
//                               WiFiForIoTPlugin.removeWifiNetwork(val!));
//                           break;
//                         default:
//                           break;
//                       }
//                     },
//                     itemBuilder: (BuildContext context) =>
//                         <PopupMenuItem<String>>[
//                       PopupMenuItem<String>(
//                         value: "disconnect",
//                         child: const Text('Disconnect'),
//                       ),
//                       PopupMenuItem<String>(
//                         value: "remove",
//                         child: const Text('Remove'),
//                       ),
//                     ],
//                   ),
//                 ]
//               : null,
//         ),
//         body: getWidgets(),
//       ),
//     );
//   }
// }

// class PopupCommand {
//   String command;
//   String argument;

//   PopupCommand(this.command, this.argument);
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_iot_wifi/flutter_iot_wifi.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('FlutterIotWifi Example'),
//         ),
//         body: const Center(
//           child: AccessPointWidget(),
//         ),
//       ),
//     );
//   }
// }

// class AccessPointWidget extends StatelessWidget {
//   const AccessPointWidget({Key? key}) : super(key: key);

//   final String ssid = "Example"; // TODO replace with your ssid
//   final String password = "12345678"; // TODO replace with your password

//   Future<bool> _checkPermissions() async {
//     if (Platform.isIOS || await Permission.location.request().isGranted) {
//       return true;
//     }
//     return false;
//   }

//   void _connect() async {
//     if (await _checkPermissions()) {
//       FlutterIotWifi.connect(ssid, password, prefix: true)
//           .then((value) => print("connect initiated: $value"));
//     } else {
//       print("don't have permission");
//     }
//   }

//   void _disconnect() async {
//     if (await _checkPermissions()) {
//       FlutterIotWifi.disconnect()
//           .then((value) => print("disconnect initiated: $value"));
//     } else {
//       print("don't have permission");
//     }
//   }

//   void _scan() async {
//     if (await _checkPermissions()) {
//       FlutterIotWifi.scan().then((value) => print("scan started: $value"));
//     } else {
//       print("don't have permission");
//     }
//   }

//   void _list() async {
//     if (await _checkPermissions()) {
//       FlutterIotWifi.list().then((value) => print("ssids: $value"));
//     } else {
//       print("don't have permission");
//     }
//   }

//   void _current() async {
//     if (await _checkPermissions()) {
//       FlutterIotWifi.current().then((value) => print("current ssid: $value"));
//     } else {
//       print("don't have permission");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Center(child: Text("SSID: $ssid, PASSWORD: $password")),
//         _CustomButton(onPressed: _connect, child: const Text("Connect")),
//         _CustomButton(onPressed: _disconnect, child: const Text("Disconnect")),
//         _CustomButton(
//             onPressed: _scan, child: const Text("Scan (Android only)")),
//         _CustomButton(
//             onPressed: _list, child: const Text("List (Android only)")),
//         _CustomButton(onPressed: _current, child: const Text("Current")),
//       ],
//     );
//   }
// }

// class _CustomButton extends StatelessWidget {
//   const _CustomButton({Key? key, required this.onPressed, required this.child})
//       : super(key: key);

//   final VoidCallback onPressed;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 40, child: ElevatedButton(onPressed: onPressed, child: child));
//   }
// }

// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:wifi_scan/wifi_scan.dart';

// void main() {
//   runApp(const MyApp());
// }

// /// Example app for wifi_scan plugin.
// class MyApp extends StatefulWidget {
//   /// Default constructor for [MyApp] widget.
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
//   StreamSubscription<List<WiFiAccessPoint>>? subscription;
//   bool shouldCheckCan = true;

//   bool get isStreaming => subscription != null;

//   Future<void> _startScan(BuildContext context) async {
//     // check if "can" startScan
//     if (shouldCheckCan) {
//       // check if can-startScan
//       final can = await WiFiScan.instance.canStartScan();
//       // if can-not, then show error
//       if (can != CanStartScan.yes) {
//         if (mounted) kShowSnackBar(context, "Cannot start scan: $can");
//         return;
//       }
//     }

//     // call startScan API
//     final result = await WiFiScan.instance.startScan();
//     if (mounted) kShowSnackBar(context, "startScan: $result");
//     // reset access points.
//     setState(() => accessPoints = <WiFiAccessPoint>[]);
//   }

//   Future<bool> _canGetScannedResults(BuildContext context) async {
//     if (shouldCheckCan) {
//       // check if can-getScannedResults
//       final can = await WiFiScan.instance.canGetScannedResults();
//       // if can-not, then show error
//       if (can != CanGetScannedResults.yes) {
//         if (mounted) kShowSnackBar(context, "Cannot get scanned results: $can");
//         accessPoints = <WiFiAccessPoint>[];
//         return false;
//       }
//     }
//     return true;
//   }

//   Future<void> _getScannedResults(BuildContext context) async {
//     if (await _canGetScannedResults(context)) {
//       // get scanned results
//       final results = await WiFiScan.instance.getScannedResults();
//       setState(() => accessPoints = results);
//     }
//   }

//   Future<void> _startListeningToScanResults(BuildContext context) async {
//     if (await _canGetScannedResults(context)) {
//       subscription = WiFiScan.instance.onScannedResultsAvailable
//           .listen((result) => setState(() => accessPoints = result));
//     }
//   }

//   void _stopListeningToScanResults() {
//     subscription?.cancel();
//     setState(() => subscription = null);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // stop subscription for scanned results
//     _stopListeningToScanResults();
//   }

//   // build toggle with label
//   Widget _buildToggle({
//     String? label,
//     bool value = false,
//     ValueChanged<bool>? onChanged,
//     Color? activeColor,
//   }) =>
//       Row(
//         children: [
//           if (label != null) Text(label),
//           Switch(value: value, onChanged: onChanged, activeColor: activeColor),
//         ],
//       );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//           actions: [
//             _buildToggle(
//                 label: "Check can?",
//                 value: shouldCheckCan,
//                 onChanged: (v) => setState(() => shouldCheckCan = v),
//                 activeColor: Colors.purple)
//           ],
//         ),
//         body: Builder(
//           builder: (context) => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.perm_scan_wifi),
//                       label: const Text('SCAN'),
//                       onPressed: () async => _startScan(context),
//                     ),
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.refresh),
//                       label: const Text('GET'),
//                       onPressed: () async => _getScannedResults(context),
//                     ),
//                     _buildToggle(
//                       label: "STREAM",
//                       value: isStreaming,
//                       onChanged: (shouldStream) async => shouldStream
//                           ? await _startListeningToScanResults(context)
//                           : _stopListeningToScanResults(),
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//                 Flexible(
//                   child: Center(
//                     child: accessPoints.isEmpty
//                         ? const Text("NO SCANNED RESULTS")
//                         : ListView.builder(
//                             itemCount: accessPoints.length,
//                             itemBuilder: (context, i) =>
//                                 _AccessPointTile(accessPoint: accessPoints[i])),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Show tile for AccessPoint.
// ///
// /// Can see details when tapped.
// class _AccessPointTile extends StatelessWidget {
//   final WiFiAccessPoint accessPoint;

//   const _AccessPointTile({Key? key, required this.accessPoint})
//       : super(key: key);

//   // build row that can display info, based on label: value pair.
//   Widget _buildInfo(String label, dynamic value) => Container(
//         decoration: const BoxDecoration(
//           border: Border(bottom: BorderSide(color: Colors.grey)),
//         ),
//         child: Row(
//           children: [
//             Text(
//               "$label: ",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Expanded(child: Text(value.toString()))
//           ],
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     final title = accessPoint.ssid.isNotEmpty ? accessPoint.ssid : "**EMPTY**";
//     final signalIcon = accessPoint.level >= -80
//         ? Icons.signal_wifi_4_bar
//         : Icons.signal_wifi_0_bar;
//     return ListTile(
//       visualDensity: VisualDensity.compact,
//       leading: Icon(signalIcon),
//       title: Text(title),
//       subtitle: Text(accessPoint.capabilities),
//       onTap: () => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(title),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildInfo("BSSDI", accessPoint.bssid),
//               _buildInfo("Capability", accessPoint.capabilities),
//               _buildInfo("frequency", "${accessPoint.frequency}MHz"),
//               _buildInfo("level", accessPoint.level),
//               _buildInfo("standard", accessPoint.standard),
//               _buildInfo(
//                   "centerFrequency0", "${accessPoint.centerFrequency0}MHz"),
//               _buildInfo(
//                   "centerFrequency1", "${accessPoint.centerFrequency1}MHz"),
//               _buildInfo("channelWidth", accessPoint.channelWidth),
//               _buildInfo("isPasspoint", accessPoint.isPasspoint),
//               _buildInfo(
//                   "operatorFriendlyName", accessPoint.operatorFriendlyName),
//               _buildInfo("venueName", accessPoint.venueName),
//               _buildInfo("is80211mcResponder", accessPoint.is80211mcResponder),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Show snackbar.
// void kShowSnackBar(BuildContext context, String message) {
//   if (kDebugMode) print(message);
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(SnackBar(content: Text(message)));
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:io' show Platform;

const String STA_DEFAULT_SSID = "STA_SSID";
const String STA_DEFAULT_PASSWORD = "STA_PASSWORD";
const NetworkSecurity STA_DEFAULT_SECURITY = NetworkSecurity.WPA;

const String AP_DEFAULT_SSID = "AP_SSID";
const String AP_DEFAULT_PASSWORD = "AP_PASSWORD";

void main() => runApp(FlutterWifiIoT());

class FlutterWifiIoT extends StatefulWidget {
  @override
  _FlutterWifiIoTState createState() => _FlutterWifiIoTState();
}

class _FlutterWifiIoTState extends State<FlutterWifiIoT> {
  String? _sPreviousAPSSID = "";
  String? _sPreviousPreSharedKey = "";

  List<WifiNetwork?>? _htResultNetwork;
  Map<String, bool>? _htIsNetworkRegistered = Map();

  bool _isEnabled = false;
  bool _isConnected = false;
  bool _isWiFiAPEnabled = false;
  bool _isWiFiAPSSIDHidden = false;
  bool _isWifiAPSupported = true;
  bool _isWifiEnableOpenSettings = false;
  bool _isWifiDisableOpenSettings = false;

  final TextStyle textStyle = TextStyle(color: Colors.white);

  @override
  initState() {
    WiFiForIoTPlugin.isEnabled().then((val) {
      _isEnabled = val;
    });

    WiFiForIoTPlugin.isConnected().then((val) {
      _isConnected = val;
    });

    WiFiForIoTPlugin.isWiFiAPEnabled().then((val) {
      _isWiFiAPEnabled = val;
    }).catchError((val) {
      _isWifiAPSupported = false;
    });

    super.initState();
  }

  storeAndConnect(String psSSID, String psKey) async {
    await storeAPInfos();
    await WiFiForIoTPlugin.setWiFiAPSSID(psSSID);
    await WiFiForIoTPlugin.setWiFiAPPreSharedKey(psKey);
  }

  storeAPInfos() async {
    String? sAPSSID;
    String? sPreSharedKey;

    try {
      sAPSSID = await WiFiForIoTPlugin.getWiFiAPSSID();
    } on PlatformException {
      sAPSSID = "";
    }

    try {
      sPreSharedKey = await WiFiForIoTPlugin.getWiFiAPPreSharedKey();
    } on PlatformException {
      sPreSharedKey = "";
    }

    setState(() {
      _sPreviousAPSSID = sAPSSID;
      _sPreviousPreSharedKey = sPreSharedKey;
    });
  }

  restoreAPInfos() async {
    WiFiForIoTPlugin.setWiFiAPSSID(_sPreviousAPSSID!);
    WiFiForIoTPlugin.setWiFiAPPreSharedKey(_sPreviousPreSharedKey!);
  }

  // [sAPSSID, sPreSharedKey]
  Future<List<String>> getWiFiAPInfos() async {
    String? sAPSSID;
    String? sPreSharedKey;

    try {
      sAPSSID = await WiFiForIoTPlugin.getWiFiAPSSID();
    } on Exception {
      sAPSSID = "";
    }

    try {
      sPreSharedKey = await WiFiForIoTPlugin.getWiFiAPPreSharedKey();
    } on Exception {
      sPreSharedKey = "";
    }

    return [sAPSSID!, sPreSharedKey!];
  }

  Future<WIFI_AP_STATE?> getWiFiAPState() async {
    int? iWiFiState;

    WIFI_AP_STATE? wifiAPState;

    try {
      iWiFiState = await WiFiForIoTPlugin.getWiFiAPState();
    } on Exception {
      iWiFiState = WIFI_AP_STATE.WIFI_AP_STATE_FAILED.index;
    }

    if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_DISABLING.index) {
      wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_DISABLING;
    } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_DISABLED.index) {
      wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_DISABLED;
    } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_ENABLING.index) {
      wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_ENABLING;
    } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_ENABLED.index) {
      wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_ENABLED;
    } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_FAILED.index) {
      wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_FAILED;
    }

    return wifiAPState!;
  }

  Future<List<APClient>> getClientList(
      bool onlyReachables, int reachableTimeout) async {
    List<APClient> htResultClient;

    try {
      htResultClient = await WiFiForIoTPlugin.getClientList(
          onlyReachables, reachableTimeout);
    } on PlatformException {
      htResultClient = <APClient>[];
    }

    return htResultClient;
  }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }

    return htResultNetwork;
  }

  isRegisteredWifiNetwork(String ssid) async {
    bool bIsRegistered;

    try {
      bIsRegistered = await WiFiForIoTPlugin.isRegisteredWifiNetwork(ssid);
    } on PlatformException {
      bIsRegistered = false;
    }

    setState(() {
      _htIsNetworkRegistered![ssid] = bIsRegistered;
    });
  }

  void showClientList() async {
    /// Refresh the list and show in console
    getClientList(false, 300).then((val) => val.forEach((oClient) {
          print("************************");
          print("Client :");
          print("ipAddr = '${oClient.ipAddr}'");
          print("hwAddr = '${oClient.hwAddr}'");
          print("device = '${oClient.device}'");
          print("isReachable = '${oClient.isReachable}'");
          print("************************");
        }));
  }

  Widget getWidgets() {
    WiFiForIoTPlugin.isConnected().then((val) {
      setState(() {
        _isConnected = val;
      });
    });

    // disable scanning for ios as not supported
    if (_isConnected || Platform.isIOS) {
      _htResultNetwork = null;
    }

    if (_htResultNetwork != null && _htResultNetwork!.length > 0) {
      List<ListTile> htNetworks = <ListTile>[];

      _htResultNetwork!.forEach((oNetwork) {
        PopupCommand oCmdConnect = PopupCommand("Connect", oNetwork!.ssid!);
        PopupCommand oCmdRemove = PopupCommand("Remove", oNetwork.ssid!);

        List<PopupMenuItem<PopupCommand>> htPopupMenuItems = [];

        htPopupMenuItems.add(
          PopupMenuItem<PopupCommand>(
            value: oCmdConnect,
            child: const Text('Connect'),
          ),
        );

        setState(() {
          isRegisteredWifiNetwork(oNetwork.ssid!);
          if (_htIsNetworkRegistered!.containsKey(oNetwork.ssid) &&
              _htIsNetworkRegistered![oNetwork.ssid]!) {
            htPopupMenuItems.add(
              PopupMenuItem<PopupCommand>(
                value: oCmdRemove,
                child: const Text('Remove'),
              ),
            );
          }

          htNetworks.add(
            ListTile(
              title: Text("" +
                  oNetwork.ssid! +
                  ((_htIsNetworkRegistered!.containsKey(oNetwork.ssid) &&
                          _htIsNetworkRegistered![oNetwork.ssid]!)
                      ? " *"
                      : "")),
              trailing: PopupMenuButton<PopupCommand>(
                padding: EdgeInsets.zero,
                onSelected: (PopupCommand poCommand) {
                  switch (poCommand.command) {
                    case "Connect":
                      WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
                          password: STA_DEFAULT_PASSWORD,
                          joinOnce: true,
                          security: STA_DEFAULT_SECURITY);
                      break;
                    case "Remove":
                      WiFiForIoTPlugin.removeWifiNetwork(poCommand.argument);
                      break;
                    default:
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => htPopupMenuItems,
              ),
            ),
          );
        });
      });

      return ListView(
        padding: kMaterialListPadding,
        children: htNetworks,
      );
    } else {
      return SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: Platform.isIOS
                ? getButtonWidgetsForiOS()
                : getButtonWidgetsForAndroid(),
          ),
        ),
      );
    }
  }

  List<Widget> getButtonWidgetsForAndroid() {
    List<Widget> htPrimaryWidgets = <Widget>[];

    WiFiForIoTPlugin.isEnabled().then((val) {
      setState(() {
        _isEnabled = val;
      });
    });

    if (_isEnabled) {
      htPrimaryWidgets.addAll([
        SizedBox(height: 10),
        Text("Wifi Enabled"),
        MaterialButton(
          color: Colors.blue,
          child: Text("Disable", style: textStyle),
          onPressed: () {
            WiFiForIoTPlugin.setEnabled(false,
                shouldOpenSettings: _isWifiDisableOpenSettings);
          },
        ),
      ]);

      WiFiForIoTPlugin.isConnected().then((val) {
        setState(() {
          _isConnected = val;
        });
      });

      if (_isConnected) {
        htPrimaryWidgets.addAll(<Widget>[
          Text("Connected"),
          FutureBuilder(
              future: WiFiForIoTPlugin.getSSID(),
              initialData: "Loading..",
              builder: (BuildContext context, AsyncSnapshot<String?> ssid) {
                return Text("SSID: ${ssid.data}");
              }),
          FutureBuilder(
              future: WiFiForIoTPlugin.getBSSID(),
              initialData: "Loading..",
              builder: (BuildContext context, AsyncSnapshot<String?> bssid) {
                return Text("BSSID: ${bssid.data}");
              }),
          FutureBuilder(
              future: WiFiForIoTPlugin.getCurrentSignalStrength(),
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int?> signal) {
                return Text("Signal: ${signal.data}");
              }),
          FutureBuilder(
              future: WiFiForIoTPlugin.getFrequency(),
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int?> freq) {
                return Text("Frequency : ${freq.data}");
              }),
          FutureBuilder(
              future: WiFiForIoTPlugin.getIP(),
              initialData: "Loading..",
              builder: (BuildContext context, AsyncSnapshot<String?> ip) {
                return Text("IP : ${ip.data}");
              }),
          MaterialButton(
            color: Colors.blue,
            child: Text("Disconnect", style: textStyle),
            onPressed: () {
              WiFiForIoTPlugin.disconnect();
            },
          ),
          CheckboxListTile(
              title: const Text("Disable WiFi on settings"),
              subtitle: const Text("Available only on android API level >= 29"),
              value: _isWifiDisableOpenSettings,
              onChanged: (bool? setting) {
                if (setting != null) {
                  setState(() {
                    _isWifiDisableOpenSettings = setting;
                  });
                }
              })
        ]);
      } else {
        htPrimaryWidgets.addAll(<Widget>[
          Text("Disconnected"),
          MaterialButton(
            color: Colors.blue,
            child: Text("Scan", style: textStyle),
            onPressed: () async {
              _htResultNetwork = await loadWifiList();
              setState(() {});
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                child: Text("Use WiFi", style: textStyle),
                onPressed: () {
                  WiFiForIoTPlugin.forceWifiUsage(true);
                },
              ),
              SizedBox(width: 50),
              MaterialButton(
                color: Colors.blue,
                child: Text("Use 3G/4G", style: textStyle),
                onPressed: () {
                  WiFiForIoTPlugin.forceWifiUsage(false);
                },
              ),
            ],
          ),
          CheckboxListTile(
              title: const Text("Disable WiFi on settings"),
              subtitle: const Text("Available only on android API level >= 29"),
              value: _isWifiDisableOpenSettings,
              onChanged: (bool? setting) {
                if (setting != null) {
                  setState(() {
                    _isWifiDisableOpenSettings = setting;
                  });
                }
              })
        ]);
      }
    } else {
      htPrimaryWidgets.addAll(<Widget>[
        SizedBox(height: 10),
        Text("Wifi Disabled"),
        MaterialButton(
          color: Colors.blue,
          child: Text("Enable", style: textStyle),
          onPressed: () {
            setState(() {
              WiFiForIoTPlugin.setEnabled(true,
                  shouldOpenSettings: _isWifiEnableOpenSettings);
            });
          },
        ),
        CheckboxListTile(
            title: const Text("Enable WiFi on settings"),
            subtitle: const Text("Available only on android API level >= 29"),
            value: _isWifiEnableOpenSettings,
            onChanged: (bool? setting) {
              if (setting != null) {
                setState(() {
                  _isWifiEnableOpenSettings = setting;
                });
              }
            })
      ]);
    }

    htPrimaryWidgets.add(Divider(
      height: 32.0,
    ));

    if (_isWifiAPSupported) {
      htPrimaryWidgets.addAll(<Widget>[
        Text("WiFi AP State"),
        FutureBuilder(
            future: getWiFiAPState(),
            initialData: WIFI_AP_STATE.WIFI_AP_STATE_DISABLED,
            builder: (BuildContext context,
                AsyncSnapshot<WIFI_AP_STATE?> wifiState) {
              List<Widget> widgets = [];

              if (wifiState.data == WIFI_AP_STATE.WIFI_AP_STATE_ENABLED) {
                widgets.add(MaterialButton(
                  color: Colors.blue,
                  child: Text("Get Client List", style: textStyle),
                  onPressed: () {
                    showClientList();
                  },
                ));
              }

              widgets.add(Text(wifiState.data.toString()));

              return Column(children: widgets);
            }),
      ]);

      WiFiForIoTPlugin.isWiFiAPEnabled()
          .then((val) => setState(() {
                _isWiFiAPEnabled = val;
              }))
          .catchError((val) {
        _isWiFiAPEnabled = false;
      });

      if (_isWiFiAPEnabled) {
        htPrimaryWidgets.addAll(<Widget>[
          Text("Wifi AP Enabled"),
          MaterialButton(
            color: Colors.blue,
            child: Text("Disable", style: textStyle),
            onPressed: () {
              WiFiForIoTPlugin.setWiFiAPEnabled(false);
            },
          ),
        ]);
      } else {
        htPrimaryWidgets.addAll(<Widget>[
          Text("Wifi AP Disabled"),
          MaterialButton(
            color: Colors.blue,
            child: Text("Enable", style: textStyle),
            onPressed: () {
              WiFiForIoTPlugin.setWiFiAPEnabled(true);
            },
          ),
        ]);
      }

      WiFiForIoTPlugin.isWiFiAPSSIDHidden()
          .then((val) => setState(() {
                _isWiFiAPSSIDHidden = val;
              }))
          .catchError((val) => _isWiFiAPSSIDHidden = false);
      if (_isWiFiAPSSIDHidden) {
        htPrimaryWidgets.add(Text("SSID is hidden"));
        !_isWiFiAPEnabled
            ? MaterialButton(
                color: Colors.blue,
                child: Text("Show", style: textStyle),
                onPressed: () {
                  WiFiForIoTPlugin.setWiFiAPSSIDHidden(false);
                },
              )
            : Container(width: 0, height: 0);
      } else {
        htPrimaryWidgets.add(Text("SSID is visible"));
        !_isWiFiAPEnabled
            ? MaterialButton(
                color: Colors.blue,
                child: Text("Hide", style: textStyle),
                onPressed: () {
                  WiFiForIoTPlugin.setWiFiAPSSIDHidden(true);
                },
              )
            : Container(width: 0, height: 0);
      }

      FutureBuilder(
          future: getWiFiAPInfos(),
          initialData: <String>[],
          builder: (BuildContext context, AsyncSnapshot<List<String>> info) {
            htPrimaryWidgets.addAll(<Widget>[
              Text("SSID : ${info.data![0]}"),
              Text("KEY  : ${info.data![1]}"),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                    "Set AP info ($AP_DEFAULT_SSID/$AP_DEFAULT_PASSWORD)",
                    style: textStyle),
                onPressed: () {
                  storeAndConnect(AP_DEFAULT_SSID, AP_DEFAULT_PASSWORD);
                },
              ),
              Text("AP SSID stored : $_sPreviousAPSSID"),
              Text("KEY stored : $_sPreviousPreSharedKey"),
              MaterialButton(
                color: Colors.blue,
                child: Text("Store AP infos", style: textStyle),
                onPressed: () {
                  storeAPInfos();
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text("Restore AP infos", style: textStyle),
                onPressed: () {
                  restoreAPInfos();
                },
              ),
            ]);

            return Text("SSID : ${info.data![0]}");
          });
    } else {
      htPrimaryWidgets.add(
          Center(child: Text("Wifi AP probably not supported by your device")));
    }

    return htPrimaryWidgets;
  }

  List<Widget> getButtonWidgetsForiOS() {
    List<Widget> htPrimaryWidgets = <Widget>[];

    WiFiForIoTPlugin.isEnabled().then((val) => setState(() {
          _isEnabled = val;
        }));

    if (_isEnabled) {
      htPrimaryWidgets.add(Text("Wifi Enabled"));
      WiFiForIoTPlugin.isConnected().then((val) => setState(() {
            _isConnected = val;
          }));

      String? _sSSID;

      if (_isConnected) {
        htPrimaryWidgets.addAll(<Widget>[
          Text("Connected"),
          FutureBuilder(
              future: WiFiForIoTPlugin.getSSID(),
              initialData: "Loading..",
              builder: (BuildContext context, AsyncSnapshot<String?> ssid) {
                _sSSID = ssid.data;

                return Text("SSID: ${ssid.data}");
              }),
        ]);

        if (_sSSID == STA_DEFAULT_SSID) {
          htPrimaryWidgets.addAll(<Widget>[
            MaterialButton(
              color: Colors.blue,
              child: Text("Disconnect", style: textStyle),
              onPressed: () {
                WiFiForIoTPlugin.disconnect();
              },
            ),
          ]);
        } else {
          htPrimaryWidgets.addAll(<Widget>[
            MaterialButton(
              color: Colors.blue,
              child: Text("Connect to '$AP_DEFAULT_SSID'", style: textStyle),
              onPressed: () {
                WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
                    password: STA_DEFAULT_PASSWORD,
                    joinOnce: true,
                    security: NetworkSecurity.WPA);
              },
            ),
          ]);
        }
      } else {
        htPrimaryWidgets.addAll(<Widget>[
          Text("Disconnected"),
          MaterialButton(
            color: Colors.blue,
            child: Text("Connect to '$AP_DEFAULT_SSID'", style: textStyle),
            onPressed: () {
              WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
                  password: STA_DEFAULT_PASSWORD,
                  joinOnce: true,
                  security: NetworkSecurity.WPA);
            },
          ),
        ]);
      }
    } else {
      htPrimaryWidgets.addAll(<Widget>[
        Text("Wifi Disabled?"),
        MaterialButton(
          color: Colors.blue,
          child: Text("Connect to '$AP_DEFAULT_SSID'", style: textStyle),
          onPressed: () {
            WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
                password: STA_DEFAULT_PASSWORD,
                joinOnce: true,
                security: NetworkSecurity.WPA);
          },
        ),
      ]);
    }

    return htPrimaryWidgets;
  }

  @override
  Widget build(BuildContext poContext) {
    return MaterialApp(
      title: Platform.isIOS
          ? "WifiFlutter Example iOS"
          : "WifiFlutter Example Android",
      home: Scaffold(
        appBar: AppBar(
          title: Platform.isIOS
              ? Text('WifiFlutter Example iOS')
              : Text('WifiFlutter Example Android'),
          actions: _isConnected
              ? <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case "disconnect":
                          WiFiForIoTPlugin.disconnect();
                          break;
                        case "remove":
                          WiFiForIoTPlugin.getSSID().then((val) =>
                              WiFiForIoTPlugin.removeWifiNetwork(val!));
                          break;
                        default:
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                        value: "disconnect",
                        child: const Text('Disconnect'),
                      ),
                      PopupMenuItem<String>(
                        value: "remove",
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                ]
              : null,
        ),
        body: getWidgets(),
      ),
    );
  }
}

class PopupCommand {
  String command;
  String argument;

  PopupCommand(this.command, this.argument);
}
