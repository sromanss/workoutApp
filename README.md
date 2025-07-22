🚀 Workout App

📋 Descrizione

Workout App è un'app cross-platform sviluppata con Flutter e Dart. Ideale per gestire ogni fase del tuo allenamento:

Visualizza allenamenti consigliati

Crea e gestisci i tuoi workout personalizzati

Leggi e scrivi recensioni con valutazioni a stelle ⭐️

Configura notifiche e promemoria

Offline mode con dati mock locali

Il backend è basato su Firebase, mentre lo stato è gestito con il Provider Pattern.

🔑 Funzionalità principali: 

1-🔐 Autenticazione

Email & Password per login e registrazione

2-🏠 Home 3 Tab:

                • Consigliati: allenamenti predefiniti

                • Personali: crea / modifica / elimina i tuoi workout

                • Profilo: dat i utente, impostazioni e logout

3-📖 Dettaglio Workout

Titolo, durata, descrizione, difficoltà, autore, lista esercizi

• Vedi / aggiungi recensioni (solo Consigliati)

• Modifica / elimina (solo Personali o permessi admin)

4-💬 Recensioni

Elenco recensori, commenti e stelle; aggiungi la tua opinione

5-🔔 Notifiche

On/Off: generali, promemoria workout, nuove recensioni, alert admin

ℹ️ Pagine Extra

Info: versione, tech, sviluppatoreAiuto: FAQ e credenziali di test

🎯 Requisiti

Flutter SDK (Dart >=2.17)

Android Studio o VSCode con plugin Flutter

Emulatori Android/iOS o dispositivo reale

Firebase config (google-services.json e GoogleService-Info.plist)

⚙️ Installazione & Configurazione

# Clona il progetto
git clone <URL-del-progetto>
cd workout_app

# Installa dipendenze
flutter pub get

# Aggiungi Firebase
# → android/app/google-services.json
# → ios/Runner/GoogleService-Info.plist

# Avvia l'app
flutter run

🧪 Credenziali di Test

Admin

admin@workout.com/admin123

Utente

user@workout.com

user123

📂 Struttura del Progetto

/lib
 ├─ models/           # Workout, Exercise, Review, ...
 ├─ providers/        # State management (Provider)
 ├─ screens/          # UI Screens (Home, Login, Detail, ...)
 ├─ widgets/          # Componenti riutilizzabili
 ├─ services/         
pubspec.yaml          # Dipendenze e metadata

🤝 Contribuire

Fork del repository

Crea un branch: git checkout -b feature/NomeFeature

Aggiungi test e documentazione

Apri una Pull Request
