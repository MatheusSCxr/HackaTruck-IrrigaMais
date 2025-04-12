#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>

WiFiClient client;
HTTPClient httpClient;

//dados da rede Wi-Fi
const char *WIFI_SSID = "AndroidAP";
const char *WIFI_PASSWORD = "naotemsenhapublica";

#define URL_GET "http://192.168.43.100:1880/sensorGET"
#define URL_PUT "http://192.168.43.100:1880/sensorPUT"
#define SENSOR_ID 6

int sensor_pin = A0;

unsigned long startMillis;  //tempo registrado durante o boot
const unsigned long UNIX_EPOCH = 2208988800000UL; //converter para UNIX EPOCH (milissegundos de 1970)

//setup
void setup() {
    Serial.begin(115200);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("\nConectado ao Wi-Fi!");
    delay(2000);
}

//get umidade atual do sensor em porcentagem
float FazLeituraUmidade(void) {
    int ValorADC = analogRead(sensor_pin);
    float UmidadePercentual = 100 * ((1024 - (float)ValorADC) / 1024);

    Serial.print("[Leitura ADC] ");
    Serial.println(ValorADC);
    Serial.print("[Umidade Percentual] ");
    Serial.print(UmidadePercentual);
    Serial.println("%");

    return UmidadePercentual;
}

void loop() {
    //calculando o tempo UNIX Epoch em milissegundos desde 01/01/1970
    unsigned long currentMillis = millis();
    unsigned long elapsedMillis = currentMillis - startMillis;  // Tempo desde o boot
    unsigned long unixEpochMillis = UNIX_EPOCH + elapsedMillis;  // UNIX Epoch em milissegundos

    //mostra o UNIX Epoch em milissegundos no Serial Monitor
    Serial.print("Tempo UNIX Epoch (milissegundos) desde 1970: ");
    Serial.println(unixEpochMillis);

    //GET dos sensores
    httpClient.begin(client, URL_GET);
    httpClient.setTimeout(10000);  // Aumenta o tempo de espera para 10 segundos

    int httpCode = httpClient.GET();

    if (httpCode > 0) {
        String payload = httpClient.getString();
        Serial.println(payload);
        httpClient.end();

        //Parse JSON de todos os sensores
        StaticJsonDocument<1024> doc;
        DeserializationError error = deserializeJson(doc, payload);
        if (error) {
            Serial.print("Erro ao parsear JSON: ");
            Serial.println(error.c_str());
            return;
        }

        JsonArray sensores = doc.as<JsonArray>();

        //encontra o sensor com id = 1
        JsonObject sensor;
        bool foundSensor = false;

        for (JsonObject obj : sensores) {
            if ((int)obj["id"] == SENSOR_ID) {
                sensor = obj;  //atualiza com o sensor com id = 1
                foundSensor = true;
                break;
            }
        }

        if (!foundSensor) {
            Serial.println("Sensor ID 1 não encontrado!");
            return;
        }

        //adiciona nova leitura
        float umidade = FazLeituraUmidade();
        JsonArray leituras = sensor["leituras"].as<JsonArray>();
        JsonArray datas = sensor["datas"].as<JsonArray>();

        if (!leituras.isNull()) {
            leituras.add((int)umidade);  //adiciona o valor de umidade
        }
        if (!datas.isNull()) {
            datas.add(unixEpochMillis);  //adiciona o timestamp UNIX Epoch
        }

        //serializa o JSON do sensor atualizado
        String jsonString;
        serializeJson(sensor, jsonString);

        //envia atualiza (PUT) com o sensor atualizado
        httpClient.begin(client, URL_PUT);
        httpClient.addHeader("Content-Type", "application/json");

        int putCode = httpClient.PUT(jsonString);
        String response = httpClient.getString();
        httpClient.end();

        Serial.print("[HTTP ");
        Serial.print(putCode);
        Serial.print("] Resposta: ");
        Serial.println(response);

    } else {
        Serial.print("Erro no GET: ");
        Serial.println(httpCode);
        String response = httpClient.getString();
        Serial.println(response);  //exibe a mensagem de erro do servidor
        httpClient.end();
    }

    delay(15000);  //esperar 15 segundos
}