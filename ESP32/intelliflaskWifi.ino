/*

  INTELLIFLASK
  (Esp32 Microcontroller Code)

  Fredi Romo 2023

*/




#include <WiFi.h>


//SSID Y PASSWORD PARA EL AP
const char* ssid     = "intelliflask";
const char* password = "intelliflask";  //NULL SI NO HAY CONTRASEÑA

WiFiServer server(80); //PUERTO 80

// Variable to store the HTTP request
String header;

//VARS PARA EL TIMEOUT
unsigned int currentTime = millis();
unsigned int previousTime = 0;  
unsigned long timeoutTime = 2000; //Timeout time (milis)

//SENSOR DE AGUA
#define POWER_PIN_WATER  4 // ESP32 pin (36)VN connected to sensor's VCC pin
#define SIGNAL_PIN_WATER 13 // ESP32 pin GIOP13 (ADC0) connected to sensor's signal pin
int waterValue = 0 ;


////TEMPERATURA
#define ADC_VREF_mV    3300.0 // in millivolt
#define ADC_RESOLUTION 4096.0
#define PIN_LM35       36 // ESP32 pin GIOP36 (ADC0) connected to LM35

//Ultrasónico
#define trigPin 27
#define echoPin 26
long duration;
int distance;



void GetDistance(){
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  // Calculating the distance
  distance = duration * 0.034 / 2;

  //FOR DEBUGING
  //Serial.print("Distance: ");
  //Serial.println(distance);
}




void setup() {
  Serial.begin(115200);
  
  pinMode(SIGNAL_PIN_WATER, INPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  //INICIALIZAR ACCESS POINT WIFI
  Serial.print("Setting AP (Access Point)…");
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
  Serial.print("MAC ADDRS: ");
  //Serial.println(WiFi.macAddress()); SE NECESITA EL MAC ADDRESS PARA DARLO DE ALTA EN IoT-TEC
  server.begin();
}





void loop(){
  

  WiFiClient client = server.available();   // Listen for incoming clients
  if (client) {                             // If a new client connects
    currentTime = millis();
    previousTime = currentTime;
    Serial.println("New Client.");          // 
    String currentLine = "";                // String to hold incoming data
    while (client.connected() && currentTime - previousTime <= timeoutTime) {  // loop while the client's connected
      currentTime = millis();
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        Serial.write(c);                    // print it out the serial monitor
        header += c;
        if (c == '\n') {                    // if the byte is a newline character
                                            // if the current line is blank, you got two newline characters in a row.
                                            // that's the end of the client HTTP request, so send a response:

          if (currentLine.length() == 0) {

            
            //HTTP HEADER
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
            
            //  EJEMPLO DE RECIVIR DATA  //
            /*if (header.indexOf("GET /26/on") >= 0) {
              Serial.println("GPIO 26 on");
              output26State = "on";
              digitalWrite(output26, HIGH);
            } */
            
            


            //Lectura de temperatura
            int adcVal = analogRead(PIN_LM35);
            float milliVolt = adcVal * (ADC_VREF_mV / ADC_RESOLUTION); // convert the ADC value to voltage in millivolt
            float tempC = milliVolt / 10;
           


            //MANDAR DATOS AL CLIENTE
            client.println("<!DOCTYPE html><html>");
            client.print("T:");
            client.print(tempC);
            Serial.print("temp: ");
            Serial.println(tempC);
            GetDistance();
            client.print("L:");
            client.print(1-(float)map(distance, 0, 23, 0, 100)/100);
            client.println("</body></html>");
            
            // LA RESPUESTA HTTP TERMINA CON LINEA EN BLANCO
            client.println();

            break;
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }


    // CLEAR HEADER
    header = "";
    // CLOSE CONECTION
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");

    delay(500); //DELAY GENERAL PARA LECTURA DE SENSORES
  }
}