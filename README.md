# SQL - Lifestyle
# Progetto di Analisi Dati Globali con SQL

Questo progetto esplora diversi dataset per analizzare e confrontare i paesi su temi chiave come **economia, popolazione, energia ed emissioni di CO2, e migrazione**. L'obiettivo è fornire una comprensione approfondita delle dinamiche globali attraverso l'analisi dei dati.

## Dataset Utilizzati

Il progetto si basa su tre dataset principali:

*   **Global Country Information Dataset (world\_data\_2023)**: Contiene dati del 2023 su indicatori economici, demografici e ambientali a livello globale. La tabella `world_data_2023` include informazioni come densità di popolazione, area agricola, area totale, dimensioni delle forze armate, tasso di natalità, emissioni di CO2, PIL, tasso di fertilità, aspettativa di vita, tasso di disoccupazione, popolazione urbana, coordinate geografiche, e altro.
*   **Global Data on Sustainable Energy (GDOSE)**: Offre dati sull'energia sostenibile nel mondo. La tabella `GDOSE` contiene dati dal 2000 al 2020 su accesso all'elettricità, accesso a combustibili puliti per cucinare, capacità di generazione di energia rinnovabile pro capite, flussi finanziari verso i paesi in via di sviluppo, quota di energia rinnovabile nel consumo finale, elettricità da combustibili fossili, nucleare e rinnovabili, consumo di energia primaria pro capite, intensità energetica, emissioni di CO2, crescita del PIL, PIL pro capite, densità di popolazione, area, latitudine e longitudine.
*   **Global Missing Migrants Dataset (GMMD)**: Fornisce informazioni sui flussi migratori a livello mondiale. La tabella `GMMD` include dati su tipo di incidente, anno, mese, rotta migratoria, regione di origine, numero di morti e dispersi, numero di morti, numero minimo stimato di dispersi e numero di sopravvissuti.

## Struttura del Progetto

Il progetto è organizzato come segue:

1.  **Creazione delle Tabelle**:
    *   Vengono create le tabelle `world_data_2023`, `GMMD` e `GDOSE` per contenere i dati dai rispettivi dataset.
2.  **Unione delle Tabelle**:
    *   Viene creata una tabella di confronto `comparison_2019_2023` unendo `world_data_2023` e `GDOSE` per analizzare le variazioni di emissioni di CO2 e PIL tra il 2019 e il 2023.
3.  **Analisi delle Emissioni di CO2**:
    *   Calcolo delle emissioni di CO2 pro capite per paese nel 2023.
    *   Calcolo delle emissioni totali di CO2 nel 2023.
    *   Analisi delle variazioni delle emissioni di CO2 tra il 2000 e il 2019.
    *   Analisi delle variazioni delle emissioni di CO2 tra il 2019 e il 2023.
4.  **Analisi dell'Energia**:
    *   Analisi dell'accesso all'elettricità tra il 2000 e il 2019.
    *   Analisi della produzione di energia elettrica da combustibili fossili, nucleare e rinnovabili tra il 2000 e il 2020.
5.  **Analisi delle Migrazioni**:
    *   Analisi del numero di morti, dispersi e sopravvissuti per anno e per rotta migratoria.
    *   Analisi del numero di morti, dispersi e sopravvissuti in base alla regione di origine.
6.  **Analisi delle Correlazioni**:
    *   Analisi delle correlazioni tra emissioni di CO2 e densità di popolazione, e tra emissioni di CO2 e PIL pro capite nel 2023.
    *   Analisi della correlazione tra PIL pro capite e indicatori di salute (tasso di fertilità, mortalità infantile, aspettativa di vita e tasso di mortalità materna).
    *   Verifica dell'ipotesi che le rotte migratorie con più vittime sono percorse da persone provenienti dai paesi più poveri, confrontando il PIL pro capite dei paesi di origine con i dati sulle migrazioni.
7.  **Analisi della variazione del GDP**:
    *   Analisi della variazione del GDP tra il 2019 e il 2023.

## Obiettivi dell'Analisi

*   Identificare i paesi con le **maggiori emissioni di CO2**, sia totali che pro capite.
*   Valutare l'andamento della **transizione energetica**, con particolare attenzione alla crescita delle fonti rinnovabili.
*   Comprendere l'impatto delle migrazioni e la loro correlazione con il PIL pro capite dei paesi di origine.
*   Esaminare la relazione tra **sviluppo economico** (PIL pro capite) e indicatori di salute.
*   Analizzare le variazioni delle **emissioni di CO2 e PIL** nel periodo 2019-2023.

## Tool Utilizzati

*   **Excel**: Per la creazione di grafici.
*   **Canva**: Per la creazione della presentazione.
*   **DBeaver**: Per la scrittura degli script SQL.
*   **ChatGPT**: Per l'ottimizzazione dello script e per la creazione di immagini.

## Come Utilizzare

1.  Assicurati di avere un database SQL (es. PostgreSQL) pronto per eseguire gli script.
2.  Importa i dati dai dataset nelle tabelle corrispondenti nel tuo database.
3.  Esegui gli script SQL forniti per creare le tabelle e effettuare le analisi.
4.  Esamina i risultati delle query per approfondire la tua conoscenza dei dati.

## Risultati Principali

*   **Le emissioni globali di CO2 sono in aumento**.
*   Molti paesi con **alte emissioni pro capite sono anche paesi produttori di petrolio e gas naturale**.
*   La **transizione energetica verso le fonti rinnovabili sta guadagnando terreno**, ma c'è ancora molta strada da fare.
*   Le **rotte migratorie più pericolose sono spesso percorse da persone provenienti dai paesi più poveri**.
*   Il **PIL pro capite influenza in modo significativo gli indicatori di salute**.

## Conclusioni

Questo progetto fornisce un'analisi approfondita di dati globali su economia, energia, migrazione e ambiente, utilizzando SQL per estrarre informazioni utili e creare una visione d'insieme di queste dinamiche complesse. I risultati sottolineano l'importanza di azioni concrete per la sostenibilità, l'accesso all'energia e la gestione dei flussi migratori.
