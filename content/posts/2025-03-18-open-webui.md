---
date: 2025-03-18T21:21:17+01:00
draft: false
title: AI med Open WebUI
lang: sv
categories:
- AI
- Tech
tags:
- ChatGPT
- OpenAI
- Open WebUI
- Docker
summary: Använd Open WebUI för att komma åt alla ChatGPT-modeller utan abonnemangskostnad.
---

# Hur du kan sätta upp Open WebUI med Docker för att använda OpenAI:s API

Tänk om du kunde få en ChatGPT-liknande upplevelse med alla OpenAI:s modeller, utan att behöva betala för ChatGPT Plus, Pro eller Team? Med Open WebUI och lite tekniskt trixande kan du göra precis detta! I detta blogginlägg går vi igenom vad Open WebUI är och hur du kan sätta upp det med Docker för att ansluta till OpenAI:s API.

## Vad är Open WebUI?

Open WebUI (tidigare Ollama Web UI) är ett öppet källkodsprojekt som erbjuder ett elegant och funktionsrikt webbgränssnitt för att interagera med olika språkmodeller. Det fungerar som ett alternativt gränssnitt till ChatGPT, fast där du kan använda din egen API-nyckel från OpenAI eller andra leverantörer.

Fördelar med Open WebUI:

-   **Tillgång till alla OpenAI-modeller** (GPT-4o, O3 mini, men även den senaste 4.5-modellen)
-   **Dela användning** - flera användare kan använda samma API-nyckel
-   **Spara pengar (eventuellt)** - du betalar bara för faktisk API-användning. Det kan fortfarande bli dyrt, men du har ingen fast månadsavgift utan betalar bara för det du använder.
-   **Skapa och hantera flera chattar**
-   **Ingen begränsning i chathistorik**

## Vad du behöver för att komma igång

-   En API-nyckel från OpenAI
-   En dator med Docker installerat

## Steg 1: Skaffa en OpenAI API-nyckel

Först behöver du skapa ett konto på OpenAI:s plattform och generera en API-nyckel:

1. Gå till [OpenAI:s webbplats](https://platform.openai.com) och skapa ett konto eller logga in
2. Navigera till "API Keys" under ditt kontos inställningar
3. Klicka på "Create new secret key"
4. Kopiera nyckeln och spara den på ett säkert ställe (du kommer inte kunna se den igen)

Du kommer också behöva registera ett betalkort och köpa tokens för att använda OpenAI:s API. Tokens är den virtuella valutan som används för att betala för API-anrop.

## Steg 2: Installera Docker

Om du inte redan har Docker installerat:

-   **Windows**: Ladda ner och installera [Docker Desktop](https://www.docker.com/products/docker-desktop)
-   **Mac**: Ladda ner och installera [Docker Desktop](https://www.docker.com/products/docker-desktop)
-   **Linux**: Installera Docker genom att följa [Docker:s installationsinstruktioner för Linux](https://docs.docker.com/engine/install/ubuntu/)

Kontrollera att Docker är installerat och fungerar genom att öppna en terminal/kommandotolk och skriva:

```bash
docker run hello-world
```

## Steg 3: Starta Open WebUI med Docker

Nu är det dags att starta Open WebUI! Öppna en terminal/kommandotolk och kör följande kommando:

```bash
docker run -d \
  --name open-webui \
  -p 3000:8080 \
  -v open-webui-data:/app/backend/data \
  --restart unless-stopped \
  ghcr.io/open-webui/open-webui:main
```

Detta kommando:

-   Laddar ner Open WebUI-containern
-   Kör den i bakgrunden (`-d`)
-   Mappar port 3000 på din dator till port 8080 i containern
-   Skapar en volym för att spara dina data
-   Ställer in automatisk omstart

## Steg 4: Konfigurera och anslut till OpenAI

1. Öppna en webbläsare och gå till `http://localhost:3000`
2. Skapa ett administratörskonto när du blir ombedd
3. Navigera till "Settings" eller "Inställningar" i sidomenyn
4. Klicka på fliken "LLM Providers" eller "AI-leverantörer"
5. Hitta OpenAI i listan och klicka för att konfigurera
6. Klistra in din API-nyckel och spara
7. Se till att OpenAI är aktiverad som leverantör

## Steg 5: Börja chatta med alla OpenAI-modeller

Nu är du redo att börja använda OpenAI:s modeller:

1. Gå till "Chat" i sidomenyn
2. Skapa en ny konversation genom att klicka på "+" eller liknande
3. I modellväljaren högst upp kan du nu välja mellan alla OpenAI:s modeller som GPT-4, GPT-4o, etc.
4. Börja chatta!

## Tips för användning

-   **Håll koll på kostnaderna**: OpenAI:s API är prisbaserat på antalet tokens du använder. GPT-4 är dyrare än GPT-3.5.
-   **Rensa historik**: Om du vill spara tokens kan du rensa din chathistorik med jämna mellanrum.
-   **Experimentera med inställningar**: Du kan till exempel köra två modeller bredvid varandra för att jämföra resultat.

## Felsökning

Om något går fel, prova följande:

1. **Container startar inte**: Kontrollera om Docker körs på din dator
2. **Kan inte nå webbgränssnittet**: Verifiera att porten 3000 inte används av något annat
3. **API-anslutningsproblem**: Dubbelkolla att din API-nyckel är korrekt

För att se loggar från containern, kör:

```bash
docker logs open-webui
```

## Slutsats

Med Open WebUI har du nu tillgång till samma kraftfulla AI-modeller som finns i ChatGPT Plus, men med mer flexibilitet och potentiellt lägre kostnader eftersom du bara betalar för det du faktiskt använder. Du kan chatta med GPT-4 och andra avancerade modeller utan att behöva betala för ett dyrt abonnemang.

Glöm inte att OpenAI:s API-priser baseras på användning, så håll koll på din förbrukning för att undvika överraskningar på kortfakturan.

Lycka till med ditt nya AI-verktyg!
