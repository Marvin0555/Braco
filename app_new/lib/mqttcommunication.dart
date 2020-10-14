import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

String broker = 'mqtt.eclipse.org';
int port = 1883;
String clientIdentifier = 'tobi055';
//String username         = 'fcg.._seu_user_no_brokerrix';
//String passwd           = '0qVi...seu_pass_no_nroker';
mqtt.MqttClient client;
mqtt.MqttConnectionState connectionState;
StreamSubscription subscription;
const topic_pup1 = 'arm-ocean-1';
const topic_pup2 = 'arm-ocean-2';
const topic_pup3 = 'arm-ocean-3';
const topic_pup4 = 'arm-ocean-4';
const topic_pup5 = 'arm-ocean-5';
const topic_sub1 = 'laps-ocean-iot-1';

/*void _subscribeToTopic(String topic) {
  if (connectionState == mqtt.MqttConnectionState.connected) {
    print('[MQTT client] Subscribing to ${topic.trim()}');
    client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
  }
}*/

void sublishLocation(String subtopicName) {
  connectClient().then((value) => _subscribeToTopic(subtopicName));
}

void publishLocation(String pubtopicName, String messageVale) {
  _publishToTopic(pubtopicName, messageVale);
}

Future<void> connectClient() async {
  client = mqtt.MqttClient(broker, '');
  client.port = port;
  client.logging(on: true);
  client.keepAlivePeriod = 20;
  //client.onConnected = _onConnected;
  //client.onDisconnected = onDisconnected;
  //client.onSubscribed = onSubscribed;
  final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
      .withClientIdentifier(clientIdentifier)
      .keepAliveFor(20) // Must agree with the keep alive set above or not set
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(mqtt.MqttQos.atLeastOnce);
  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;

  try {
    await client.connect(/*(username, passwd*/);
  } /* on Exception */ catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  }

  /// Check we are connected
  if (client.connectionStatus.state == mqtt.MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, state is ${client.connectionStatus.state}');
    client.disconnect();
  }

  //subscription = client.updates.listen(_onMessage);
  //_subscribeToTopic(topic_sub1);

  /*void sublishLocation(String subtopicName) {
    _subscribeToTopic(subtopicName);
  }

  void publishLocation(String pubtopicName, String messageVale) {
    _publishToTopic(pubtopicName, messageVale);
  }*/
}

/// The subscribed callback
void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

/// The unsolicited disconnect callback
void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  //exit(-1);
}

/*void _onMessage(List<mqtt.MqttReceivedMessage> event) {
  print(event.length);
  final mqtt.MqttPublishMessage recMess =
      event[0].payload as mqtt.MqttPublishMessage;
  final String message =
      mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

  /// The above may seem a little convoluted for users only interested in the
  /// payload, some users however may be interested in the received publish message,
  /// lets not constrain ourselves yet until the package has been in the wild
  /// for a while.
  /// The payload is a byte buffer, this will be specific to the topic
  print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
      'payload is <-- ${message} -->');
  print(client.connectionState);
  print("[MQTT client] message with topic: ${event[0].topic}");
  print("[MQTT client] message with message: ${message}");
  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  print(message);
}*/

void _subscribeToTopic(String topicName) {
  //print('MQTTClientWrapper::Subscribing to the $topicName topic');
  client.subscribe(topicName, mqtt.MqttQos.exactlyOnce);
  client.updates.listen((List<mqtt.MqttReceivedMessage<mqtt.MqttMessage>> c) {
    final mqtt.MqttPublishMessage recMess = c[0].payload;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print("MQTTClientWrapper::GOT A NEW MESSAGE $message");
    print(message);
  });
}

void _publishToTopic(String pubTopic, String messagePub) {
  final builder = mqtt.MqttClientPayloadBuilder();
  builder.addString(messagePub);
  client.publishMessage(pubTopic, mqtt.MqttQos.atMostOnce, builder.payload);
}
