
#include <PubSubClient.h>
//#include <WiFi.h>
#include <ESP8266WiFi.h>
//dsewwqewqwqe
const char* ssid = "Ocean Lab Prot";
const char* password = "Ocean2904";
//const char* ssid = "Charlie 2.4";
//const char* password = "vox populi";

const char* topic_sub = "directions-ocean-1";
const char* topic_pub = "laps-ocean-iot-1"; 
const char* mqtt_id = "esp-1";

const char* BROKER_MQTT = "mqtt.eclipse.org"; //URL do broker MQTT que se deseja utilizar
int BROKER_PORT = 1883; // Porta do Broker MQTT

//String msg;

#define leftForward D4
#define leftBackward D3
#define rightForward D1
#define rightBackward D2
#define enableR D6 // pwm do motor direito
#define enableL D8 // pwm do motor esquerdo
#define defaultSpeedR 1000
#define defaultSpeedL 880

#define infraRedPin D5

bool movingForward = false;
bool movingBackwards = false;
bool stopped = true;

WiFiClient espClient;
PubSubClient MQTT(espClient);

void initMQTT(void);
void mqtt_callback(char* topic, byte* payload, unsigned int length);
void reconnectMQTT(void);
void VerificaConexaoMQTT(void);

int laps = 0;
int stopCounting = 0;
char lapsStr[50];

void initMQTT(void) 
{
    MQTT.setServer(BROKER_MQTT, BROKER_PORT);   //informa qual broker e porta deve ser conectado
    MQTT.setCallback(mqtt_callback);            //atribui função de callback (função chamada quando qualquer informação de um dos tópicos subescritos chega)
}

void mqtt_callback(char* topic, byte* payload, unsigned int length) 
{
    String msg;
  
    /* obtem a string do payload recebido */
    for(int i = 0; i < length; i++) 
    {
       char c = (char)payload[i];
       msg += c;
    }
 
    Serial.println("Chegou a seguinte string via MQTT: ");
    Serial.println(msg);
    
    /* toma ação dependendo da string recebida */
    if (msg.equals("1"))
    {   // mover para frente
        stopped = false;
        movingForward = true;
        movingBackwards = false;
        analogWrite(enableR, defaultSpeedR);
        analogWrite(enableL, defaultSpeedL);
        digitalWrite(leftBackward, LOW);
        digitalWrite(rightBackward, LOW);
        digitalWrite(leftForward, HIGH);
        digitalWrite(rightForward, HIGH);
        Serial.println("Moving Forward");
        //msg = "";
    }

        if (msg.equals("2") && stopped == false)
    {   //move-se para a direita

        analogWrite(enableR, defaultSpeedR - 550);
        analogWrite(enableL, defaultSpeedL);
        Serial.println("Moving right");
        delay(350);
        analogWrite(enableR, defaultSpeedR);

        if (movingForward == true && movingBackwards == false){
          msg = "1";
        }
        else if (movingForward == false && movingBackwards == true){
          msg = "4";
        }
    }

        if (msg.equals("3") && stopped == false)
    {   //move-se para a esquerda

        analogWrite(enableR, defaultSpeedR);
        analogWrite(enableL, defaultSpeedL - 550);
        Serial.println("Moving left");
        delay(350);
        analogWrite(enableL, defaultSpeedL);
        stopCounting = 0;
        
        if (movingForward == true && movingBackwards == false){
          msg = "1";
        }
        else if (movingForward == false && movingBackwards == true){
          msg = "4";
        }
    }
  
    if (msg.equals("4"))
    {   
        stopped = false;
        movingForward = false;
        movingBackwards = true;
        analogWrite(enableR, defaultSpeedR);
        analogWrite(enableL, defaultSpeedL);
        digitalWrite(leftForward, LOW);
        digitalWrite(rightForward, LOW);
        digitalWrite(leftBackward, HIGH);
        digitalWrite(rightBackward, HIGH);
        Serial.print("Moving Backwards"); 
        //msg = "";
    }

    if (msg.equals("5"))
    {    
        stopped = true;
        movingForward = false;
        movingBackwards = false;
        digitalWrite(leftForward, LOW);
        digitalWrite(rightForward, LOW);
        digitalWrite(leftBackward, LOW);
        digitalWrite(rightBackward, LOW);
        Serial.print("Stopping"); 
        //msg = "";
    }

    Serial.println(msg);
    
}

void reconnectMQTT(void) 
{
    while (!MQTT.connected()) 
    {
        Serial.print("* Tentando se conectar ao Broker MQTT: ");
        Serial.println(BROKER_MQTT);
        if (MQTT.connect(mqtt_id)) 
        {
            Serial.println("Conectado com sucesso ao broker MQTT!");
            MQTT.subscribe(topic_sub); 
        } 
        else
        {
            Serial.println("Falha ao reconectar no broker.");
            Serial.println("Havera nova tentatica de conexao em 2s");
            delay(2000);
        }
    }
}

void VerificaConexaoMQTT(void)
{
    if (!MQTT.connected()) 
        reconnectMQTT(); //se não há conexão com o Broker, a conexão é refeita
      
}
 

void setup() {
  
  Serial.begin(9600);
  pinMode(leftForward, OUTPUT);
  pinMode(rightForward, OUTPUT);
  pinMode(leftBackward, OUTPUT);
  pinMode(rightBackward, OUTPUT);
  pinMode(enableR, OUTPUT);
  pinMode(enableL, OUTPUT);
  pinMode(infraRedPin, INPUT);
  WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
    }
  Serial.println("WiFi Connected....IP Address:");
  Serial.println(WiFi.localIP());

  initMQTT();

}

void loop() 
{   
    int checkLap = digitalRead(infraRedPin);
    if (checkLap == 1 && stopCounting == 0){
      laps += 1;
      sprintf(lapsStr, "%d", laps);
      stopCounting = 1;
    }
    VerificaConexaoMQTT();
    //Serial.println(msg);
    //publica alguma string no tópico selecionado
    MQTT.publish(topic_pub, lapsStr);
    //MQTT.publish(topic_pub, "testing");

    //keep-alive do mqtt
    MQTT.loop();
    delay(10);
    
}
