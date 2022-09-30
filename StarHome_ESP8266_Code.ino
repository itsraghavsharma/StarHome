#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif


#include <WiFiManager.h>  
#include <ESP8266WebServer.h>
ESP8266WebServer server(80);

#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>

#include "DHT.h"
#define DHT11PIN 14

DHT dht(DHT11PIN, DHT11);

//Value Variables
int val;
int val1;
int val2;
int val3;
int val4;

//Relays
int R1=D0;  
int R2=D1;
int R3=D8;
int R4=D3;

int switch1 = D2;
int switch2 = D7;
int switch3 = 3;


int motionLight=D4;

#define API_KEY "AIzaSyCmO5INBf8J8e06x-s1x-dQErPbgbD05Bc"
#define DATABASE_URL "starhome-2a781-default-rtdb.asia-southeast1.firebasedatabase.app" 


FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
unsigned long count = 0;

void handleRoot() {
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
}

void handleAcc() {

  if(digitalRead(R1) == HIGH && digitalRead(R2) == HIGH && digitalRead(R3) == HIGH && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 0) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == HIGH && digitalRead(R3) == HIGH && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 1) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == HIGH && digitalRead(R2) == LOW && digitalRead(R3) == HIGH && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 2) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == HIGH && digitalRead(R2) == HIGH && digitalRead(R3) == LOW && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 3) ? "ok" : fbdo.errorReason().c_str());
   
        }

         if(digitalRead(R1) == HIGH && digitalRead(R2) == HIGH && digitalRead(R3) == HIGH && digitalRead(R4) == LOW){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 4) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == LOW && digitalRead(R3) == HIGH && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 5) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == HIGH && digitalRead(R3) == LOW && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 6) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == HIGH && digitalRead(R3) == HIGH && digitalRead(R4) == LOW){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 7) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == LOW && digitalRead(R3) == LOW && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 8) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == LOW && digitalRead(R3) == HIGH && digitalRead(R4) == LOW){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 9) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == HIGH && digitalRead(R3) == LOW && digitalRead(R4) == LOW){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 10) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == LOW && digitalRead(R2) == LOW && digitalRead(R3) == LOW && digitalRead(R4) == LOW){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 11) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == HIGH && digitalRead(R2) == LOW && digitalRead(R3) == LOW && digitalRead(R4) == HIGH){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 12) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == HIGH && digitalRead(R2) == LOW && digitalRead(R3) == HIGH && digitalRead(R4) == LOW){
         
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 13) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == HIGH && digitalRead(R2) == LOW && digitalRead(R3) == LOW && digitalRead(R4) == LOW){
      
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 14) ? "ok" : fbdo.errorReason().c_str());
   
        }

        else if(digitalRead(R1) == HIGH && digitalRead(R2) == HIGH && digitalRead(R3) == LOW && digitalRead(R4) == LOW){
         Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 15) ? "ok" : fbdo.errorReason().c_str());
   
        }
  
}
void handleAccessories() {

for (int i = 0; i < server.args(); i++) {

    if (server.argName(i) == "App1Off") {

  
     digitalWrite(R1, HIGH);
     Serial.println("Appliance 1 is Off");

       
       
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>Light Off</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }

 if (server.argName(i) == "App1On") {

     
     digitalWrite(R1, LOW);
     Serial.println("Appliance 1 is On");

      handleAcc();
      
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>App 1 On</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }

if (server.argName(i) == "App2Off") {

     
     digitalWrite(R2, HIGH);
     Serial.println("Appliance 2 is Off");

       
      handleAcc();
      
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>App 2 Off</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }

if (server.argName(i) == "App2On") {

     
     digitalWrite(R2, LOW);
     Serial.println("Appliance 2 is On");

       
     handleAcc();
     
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>App 2 On</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }
if (server.argName(i) == "App3Off") {

     
     digitalWrite(R3, HIGH);
     Serial.println("Appliance 3 is Off");

       
       handleAcc();
       
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>Light Off</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }

if (server.argName(i) == "App3On") {

     
     digitalWrite(R3, LOW);
     Serial.println("Appliance 3 is On");

       
       handleAcc();
       
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>App 3 On</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }

if (server.argName(i) == "App4Off") {

     
     digitalWrite(R4, LOW);
     Serial.println("Appliance 4 is Off");

       handleAcc();
       
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>App 4 Off</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }
if (server.argName(i) == "App4On") {

     
     digitalWrite(R4, LOW);
     Serial.println("Appliance 4 is On");

       
      handleAcc();
      
  server.send(200, "text/html",
              "<html>" \
                "<head><title>Star Home</title></head>" \
                "<body>" \
                "<center>" \
                  "<h1>Home Automation | Star Home</h1>" \
                  "<h1>Project Exhibition -- Group 280</h1>" \
                  "<h1>App 4 On</h1>" \
                      "<center>" \
                  "<p><a href=\"app?App1On=1\">App 1 On</a></p>" \
                  "<p><a href=\"app?App1Off=1\">App 1 Off</a></p>" \
                  "<p><a href=\"app?App2On=1\">App 2 On</a></p>" \
                  "<p><a href=\"app?App2Off=1\">App 2 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 3 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 3 Off</a></p>" \
      "<p><a href=\"app?App3On=1\">App 4 On</a></p>" \
                  "<p><a href=\"app?App3Off=1\">App 4 Off</a></p>" \
               "<br>"\
               "<br>"\
               "<h1>Presented to Dr. Gopal Tandel Sir</h1>"
                  "<center>" \  
                "</body>" \
              "</html>");
     
    }





  }


  handleRoot();
}


void handleNotFound() {
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET)?"GET":"POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i = 0; i < server.args(); i++)
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  server.send(404, "text/plain", message);
}

int sensor = D6;

void setup()
{

  Serial.begin(115200);

  pinMode(switch1, INPUT_PULLUP);
  pinMode(switch2, INPUT_PULLUP);
  pinMode(switch3, INPUT_PULLUP);
 

  pinMode(R1, OUTPUT);
  pinMode(R2, OUTPUT);
  pinMode(R3, OUTPUT);
  pinMode(R4, OUTPUT);
  pinMode(motionLight, OUTPUT);
  
  digitalWrite(R1,HIGH);
  digitalWrite(R2,HIGH);
  digitalWrite(R3,HIGH);
  digitalWrite(R4,HIGH);
  digitalWrite(motionLight,HIGH);

  dht.begin();
  
  WiFiManager wifiManager;
  wifiManager.setBreakAfterConfig(true);
  if (!wifiManager.autoConnect("Star Home")) {
    Serial.println("failed to connect, we should reset as see if it connects");
    delay(3000);
    ESP.reset();
    delay(5000);
  } 
   
  Serial.println("connected to wifi!...");
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);
  Serial.println("HTTP server started");
  Serial.println("local ip");
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.on("/app", handleAccessories);
  server.on("/About", [](){
    server.send(200, "text/plain", "Star Home Project, Under Developement!");
  });
  server.onNotFound(handleNotFound);
  server.begin();

  
  String IpAdress = (WiFi.localIP()).toString();
  
  //config.api_key = API_KEY;
  config.signer.test_mode = true;
  //config.database_url = DATABASE_URL;
  //config.token_status_callback = tokenStatusCallback; 
  config.database_url = DATABASE_URL;
  config.signer.tokens.legacy_token = "<JNP6zEoatbjPqzBTbJgCSqajH4Sv5WMdX1WcbUFc>";

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  Firebase.setDoubleDigits(5);

  Serial.printf("Set Relay Status... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), 0) ? "ok" : fbdo.errorReason().c_str());
    
}
    float humi = dht.readHumidity();
    float temp = dht.readTemperature();

    bool switcher1 = false;
    bool switcher2 = false;
    bool switcher3 = false;

bool Switch1On = false;

bool Switch2On = false;

bool Switch3On = false;

bool Switch4On = false;


float lastTemp = 0.0;
float lastHumid = 0.0;
    
void loop()
{
   
    
  if (Firebase.ready())
  {

    sendDataPrevMillis = millis();
    
   // Serial.printf("Set int... %s\n", Firebase.setInt(fbdo, F("/SerialNumbers/190886532457856/Relay"), bVal) ? "ok" : fbdo.errorReason().c_str());

   if(count % 5 == 0)
   {
     humi = dht.readHumidity();
    temp = dht.readTemperature();

    if(lastTemp != temp)
    {
      Serial.printf("Set string... %s\n", Firebase.setString(fbdo, F("/SerialNumbers/190886532457856/temperature"), String(temp) + "°C") ? "ok" : fbdo.errorReason().c_str());
      lastTemp = temp;
      }
      if(lastHumid != humi)
    {
      Serial.printf("Set string... %s\n", Firebase.setString(fbdo, F("/SerialNumbers/190886532457856/humidity"), String(humi) + "%") ? "ok" : fbdo.errorReason().c_str());
      lastHumid = humi;
 }
      
    }
   
      Serial.printf("Get int ref... %s\n", Firebase.getInt(fbdo, F("SerialNumbers/190886532457856/Relay"), &val) ? String(val).c_str() : fbdo.errorReason().c_str());
    
  if (val == 0)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,HIGH);

    switcher1 = false;
    switcher2 = false;
    switcher3 = false;
  }

  if (val == 1)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,HIGH);
     
    switcher1 = true;
    switcher2 = false;
    switcher3 = false;
  }

  if (val == 2)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,LOW);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,HIGH);

    switcher1 = false;
    switcher2 = true;
    switcher3 = false;
  }

  if (val == 3)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,LOW);
     digitalWrite(R4,HIGH);

    switcher1 = false;
    switcher2 = false;
    switcher3 = true;
  }

  if (val == 4)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,LOW);

    switcher1 = false;
    switcher2 = false;
    switcher3 = false;
  }

  if (val == 5)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,LOW);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,HIGH);

    switcher1 = true;
    switcher2 = true;
    switcher3 = false;
  }

  if (val == 6)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,LOW);
     digitalWrite(R4,HIGH);

    switcher1 = true;
    switcher2 = false;
    switcher3 = true;
  }

  if (val == 7)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,LOW);

    switcher1 = true;
    switcher2 = false;
    switcher3 = false;
  }

  if (val == 8)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,LOW);
     digitalWrite(R3,LOW);
     digitalWrite(R4,HIGH);

    switcher1 = true;
    switcher2 = true;
    switcher3 = true;
  }

  if (val == 9)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,LOW);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,LOW);

    switcher1 = true;
    switcher2 = true;
    switcher3 = false;
  }

  if (val == 10)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,LOW);
     digitalWrite(R4,LOW);

    switcher1 = true;
    switcher2 = false;
    switcher3 = true;
  }

  if (val == 11)
  {
     digitalWrite(R1,LOW);
     digitalWrite(R2,LOW);
     digitalWrite(R3,LOW);
     digitalWrite(R4,LOW);

    switcher1 = true;
    switcher2 = true;
    switcher3 = true;
  }

  if (val == 12)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,LOW);
     digitalWrite(R3,LOW);
     digitalWrite(R4,HIGH);

    switcher1 = false;
    switcher2 = true;
    switcher3 = true;
  }

  if (val == 13)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,LOW);
     digitalWrite(R3,HIGH);
     digitalWrite(R4,LOW);

    switcher1 = false;
    switcher2 = true;
    switcher3 = false;
  }

  if (val == 14)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,LOW);
     digitalWrite(R3,LOW);
     digitalWrite(R4,LOW);

         switcher1 = false;
    switcher2 = true;
    switcher3 = true;
  }

  if (val == 15)
  {
     digitalWrite(R1,HIGH);
     digitalWrite(R2,HIGH);
     digitalWrite(R3,LOW);
     digitalWrite(R4,LOW);

    switcher1 = false;
    switcher2 = false;
    switcher3 = true;
  }
    Serial.println();

  }
  long switch1state = digitalRead(switch1);
  long switch2state = digitalRead(switch2);
  long switch3state = digitalRead(switch3);
  
 //Serial.println(digitalRead(switch1));
 // Serial.println(digitalRead(switch2));
 //  Serial.println(digitalRead(switch3));


  if(Switch1On!=false)
  {
      if (switch1state == HIGH)
        {
          Switch1On = false;
          Serial.println("Switch 1 Off!");
          digitalWrite(R1,HIGH);
          handleAcc();
         }
   }
  
  if(Switch1On!=true)
  {
      if (switch1state == LOW)
        {
          Switch1On = true;
          Serial.println("Switch 1 On!");
          digitalWrite(R1,LOW);
          handleAcc();
         }
   }


  if(Switch2On!=false)
  {
      if (switch2state == HIGH)
        {
          Switch2On = false;
          Serial.println("Switch 2 Off!");
          digitalWrite(R4,HIGH);
          handleAcc();
         }
   }
  
  if(Switch2On!=true)
  {
      if (switch2state == LOW)
        {
          Switch2On = true;
          Serial.println("Switch 2 On!");
          digitalWrite(R4,LOW);
          handleAcc();
         }
   }


  if(Switch3On!=false)
  {
      if (switch3state == HIGH)
        {
          Switch3On = false;
          Serial.println("Switch 3 Off! MOTION Sensor OFF");
          digitalWrite (motionLight, HIGH);
          //handleAcc()
         }
   }
  
  if(Switch3On!=true)
  {
      if (switch3state == LOW)
        {
          Switch3On = true;
          Serial.println("Switch 3 On! MOTION Sensor ON");
            long state = digitalRead(sensor);

              if(state == HIGH) {
                digitalWrite (motionLight, LOW);
                Serial.println("Motion detected!");
               
              }
              else {
                digitalWrite (motionLight, HIGH);
                Serial.println("Motion absent!");
               
                }
          //handleAcc()
         }
   }



 // server.handleClient();


  
     count++; 
}
