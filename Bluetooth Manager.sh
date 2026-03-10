#!/bin/bash

#--------------------------------#
#     R36S Bluetooth Manager     #
#           By Jason             #
#        dArkOs Edition          #
#--------------------------------#

# --- Root privileges check ---
if [ "$(id -u)" -ne 0 ]; then
    exec sudo -E "$0" "$@"
fi

# --- Variables ---
CURR_TTY="/dev/tty1"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
chmod 666 /dev/uinput

# Initialisation
SYSTEM_LANG=""
ES_CONF="/home/ark/.emulationstation/es_settings.cfg"
INSTALLED_FLAG="/home/ark/.bt_manager_installed"

if [ -f "$ES_CONF" ]; then
    ES_DETECTED=$(grep "name=\"Language\"" "$ES_CONF" | grep -o 'value="[^"]*"' | cut -d '"' -f 2)
    [ -n "$ES_DETECTED" ] && SYSTEM_LANG="$ES_DETECTED"
fi

# --- Config par défaut : EN ---
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition by Jason"
T_STARTING="Starting Bluetooth Manager dArkOs Edition ...\nPlease wait."
T_ERR_TITLE="Error"
T_STOPPING="Stopping Bluetooth..."
T_STARTING_BT="Starting Bluetooth..."
T_ACTION="Action"
T_BT_DISABLED="Bluetooth disabled.\nEnable it first."
T_SCAN_TITLE="Scanning"
T_NO_DEVICE="No named device detected."
T_INFO="Info"
T_NEARBY="Bluetooth nearby"
T_BACK="Back"
T_CHOOSE_DEV="Choose a device:"
T_SUCCESS="Success"
T_CONNECTED="is connected"
T_FAILED="Failed"
T_FAIL_CONNECT="Unable to connect to"
T_FAIL_MSG="Ensure device is in pairing mode."
T_NO_KNOWN="No known devices."
T_KNOWN_DEV="Known Devices"
T_CONNECT_TO="Connect to:"
T_CONNECTING_TO="Connecting to"
T_NOTHING_DEL="Nothing to delete."
T_DELETE_TITLE="Delete"
T_CHOOSE_DEL="Choose device to forget:"
T_FORGOTTEN="Device forgotten."
T_MAIN_TITLE="Main Menu"
T_QUIT="Quit"
T_STATUS="Bluetooth Status"
T_CONN_TO="Connected to"
T_NONE="None"
T_M_TOGGLE="Enable / Disable Bluetooth"
T_M_SCAN="Scan and Connect"
T_M_KNOWN="Known Devices"
T_M_FORGET="Forget a Device"
T_M_QUIT="Quit"
T_FIXING_AUDIO="Fixing audio protocols..."
T_PAIRING="Pairing in progress..."
T_INTERNET="Internet Required"
T_ACTIVE="An active internet connection is required to install components" 
T_UPDATE="Updating package lists..."
T_PACKAGE="Installing" 
T_COMPLETE="Installation complete !"
T_DEPS="Dependencies" 
T_INIT="Initializing..."
T_ON="ON"
T_OFF="OFF"
T_SCAN_INIT="Initializing Bleutooth..."
T_SCAN_PROCESS="Scanning airwaves..."
T_SCAN_RESOLV="Resolving device names..."
T_SCAN_START="Starting scan..."
T_CONN_TITLE="Connection"
T_PROCESS="Processing..."
T_POWERING="Powering on adapter..."
T_SYSTEM_FIX="Applying system fixes..."
T_DEV_DEFAULT="Device"
T_M_DISCONNECT="Disconnect a device"
T_DISCONNECTED="Disconnected"
T_REBOOT_TITLE="Reboot Required"
T_REBOOT_MSG="Installation complete! A reboot is required to activate all Bluetooth components.\n\nReboot now?"

 # --- FRANÇAIS (FR) ---
if [[ "$SYSTEM_LANG" == *"fr"* ]]; then
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition par Jason"
T_STARTING="Demarrage du Bluetooth Manager dArkOs Edition ...\nVeuillez patienter."
T_ERR_TITLE="Erreur"
T_STOPPING="Arret du Bluetooth..."
T_STARTING_BT="Demarrage du Bluetooth..."
T_ACTION="Action"
T_BT_DISABLED="Bluetooth desactive.\nActivez-le d'abord."
T_SCAN_TITLE="Recherche"
T_NO_DEVICE="Aucun appareil detecte."
T_INFO="Info"
T_NEARBY="Bluetooth a proximite"
T_BACK="Retour"
T_CHOOSE_DEV="Choisissez un appareil :"
T_SUCCESS="Succes"
T_CONNECTED="est connecte"
T_FAILED="Echec"
T_FAIL_CONNECT="Impossible de se connecter a"
T_FAIL_MSG="Verifiez que l'appareil est en mode appairage."
T_NO_KNOWN="Aucun appareil connu."
T_KNOWN_DEV="Appareils connus"
T_CONNECT_TO="Se connecter a :"
T_CONNECTING_TO="Connexion a"
T_NOTHING_DEL="Rien a supprimer."
T_DELETE_TITLE="Supprimer"
T_CHOOSE_DEL="Choisissez l'appareil a oublier :"
T_FORGOTTEN="Appareil oublie."
T_MAIN_TITLE="Menu Principal"
T_QUIT="Quitter"
T_STATUS="Statut Bluetooth"
T_CONN_TO="Connecte a"
T_NONE="Aucun"
T_M_TOGGLE="Activer / Desactiver le Bluetooth"
T_M_SCAN="Rechercher et Connecter"
T_M_KNOWN="Appareils connus"
T_M_FORGET="Oublier un appareil"
T_M_QUIT="Quitter"
T_FIXING_AUDIO="Reparation des protocoles audio..."
T_PAIRING="Appairage en cours..."
T_INTERNET="Internet requis"
T_ACTIVE="Une connexion internet active est requise pour installer les composants"
T_UPDATE="Mise a jour des listes de paquets..."
T_PACKAGE="Installation"
T_COMPLETE="Installation terminee !"
T_DEPS="Dependances"
T_INIT="Initialisation..."
T_ON="MARCHE"
T_OFF="ARRET"
T_SCAN_INIT="Initialisation Bleutooth..."
T_SCAN_PROCESS="Analyse des ondes radio..."
T_SCAN_RESOLV="Resolution des noms..."
T_SCAN_START="Demarrage du scan..."
T_CONN_TITLE="Connexion"
T_PROCESS="Traitement..."
T_POWERING="Allumage de l'adaptateur..."
T_SYSTEM_FIX="Application des correctifs systeme..."
T_DEV_DEFAULT="Appareil"
T_M_DISCONNECT="Deconnecter un périphérique"
T_DISCONNECTED="Deconnecte"
T_REBOOT_TITLE="Redemarrage requis"
T_REBOOT_MSG="Installation terminee ! Un redémarrage est nécessaire pour activer tous les composants Bluetooth.\n\nRedemarrer maintenant ?"

# --- ESPAÑOL (ES) ---
elif [[ "$SYSTEM_LANG" == *"es"* ]]; then
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition por Jason"
T_STARTING="Iniciando Bluetooth Manager dArkOs Edition ...\nPor favor espere."
T_ERR_TITLE="Error"
T_STOPPING="Deteniendo Bluetooth..."
T_STARTING_BT="Iniciando Bluetooth..."
T_ACTION="Accion"
T_BT_DISABLED="Bluetooth desactivado.\nActivelo primero."
T_SCAN_TITLE="Escaneo"
T_NO_DEVICE="No se detecto ningun dispositivo."
T_INFO="Info"
T_NEARBY="Bluetooth cercano"
T_BACK="Volver"
T_CHOOSE_DEV="Elija un dispositivo:"
T_SUCCESS="Exito"
T_CONNECTED="esta conectado"
T_FAILED="Fallo"
T_FAIL_CONNECT="No se pudo conectar a"
T_FAIL_MSG="Asegurese de que el dispositivo este en modo emparejamiento."
T_NO_KNOWN="No hay dispositivos conocidos."
T_KNOWN_DEV="Dispositivos conocidos"
T_CONNECT_TO="Conectar a:"
T_CONNECTING_TO="Conectando a"
T_NOTHING_DEL="Nada que eliminar."
T_DELETE_TITLE="Eliminar"
T_CHOOSE_DEL="Elija el dispositivo a olvidar:"
T_FORGOTTEN="Dispositivo olvidado."
T_MAIN_TITLE="Menu Principal"
T_QUIT="Salir"
T_STATUS="Estado de Bluetooth"
T_CONN_TO="Conectado a"
T_NONE="Ninguno"
T_M_TOGGLE="Activar / Desactivar Bluetooth"
T_M_SCAN="Escanear y Conectar"
T_M_KNOWN="Dispositivos conocidos"
T_M_FORGET="Olvidar un dispositivo"
T_M_QUIT="Salir"
T_FIXING_AUDIO="Reparando protocolos de audio..."
T_PAIRING="Emparejamiento en curso..."
T_INTERNET="Internet requerido"
T_ACTIVE="Se requiere una conexion a internet activa para instalar componentes"
T_UPDATE="Actualizando listas de paquetes..."
T_PACKAGE="Instalando"
T_COMPLETE="Instalacion completada !"
T_DEPS="Dependencias"
T_INIT="Inicializando..."
T_ON="ENCENDIDO"
T_OFF="APAGADO"
T_SCAN_INIT="Inicializando Bleutooth..."
T_SCAN_PROCESS="Escaneando ondas de radio..."
T_SCAN_RESOLV="Resolviendo nombres..."
T_SCAN_START="Iniciando escaneo..."
T_CONN_TITLE="Conexion"
T_PROCESS="Procesando..."
T_POWERING="Encendiendo adaptador..."
T_SYSTEM_FIX="Aplicando correcciones del sistema..."
T_DEV_DEFAULT="Dispositivo"
T_M_DISCONNECT="Desconectar un dispositivo"
T_DISCONNECTED="Desconectado"
T_REBOOT_TITLE="Reinicio requerido"
T_REBOOT_MSG="Instalacion completa! Se requiere un reinicio para activar todos los componentes Bluetooth.\n\nReiniciar ahora?"

# --- PORTUGUÊS (PT) ---
elif [[ "$SYSTEM_LANG" == *"pt"* ]]; then
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition por Jason"
T_STARTING="Iniciando Bluetooth Manager dArkOs Edition ...\nPor favor aguarde."
T_ERR_TITLE="Erro"
T_STOPPING="Parando Bluetooth..."
T_STARTING_BT="Iniciando Bluetooth..."
T_ACTION="Acao"
T_BT_DISABLED="Bluetooth desativado.\nAtive-o primeiro."
T_SCAN_TITLE="Escaneando"
T_NO_DEVICE="Nenhum dispositivo detectado."
T_INFO="Info"
T_NEARBY="Bluetooth proximo"
T_BACK="Voltar"
T_CHOOSE_DEV="Escolha um dispositivo:"
T_SUCCESS="Sucesso"
T_CONNECTED="esta conectado"
T_FAILED="Falha"
T_FAIL_CONNECT="Nao foi possivel conectar a"
T_FAIL_MSG="Certifique-se de que o dispositivo esta em modo de pareamento."
T_NO_KNOWN="Nenhum dispositivo conhecido."
T_KNOWN_DEV="Dispositivos Conhecidos"
T_CONNECT_TO="Conectar a:"
T_CONNECTING_TO="Conectando a"
T_NOTHING_DEL="Nada para deletar."
T_DELETE_TITLE="Deletar"
T_CHOOSE_DEL="Escolha o dispositivo para esquecer:"
T_FORGOTTEN="Dispositivo esquecido."
T_MAIN_TITLE="Menu Principal"
T_QUIT="Sair"
T_STATUS="Status do Bluetooth"
T_CONN_TO="Conectado a"
T_NONE="Nenhum"
T_M_TOGGLE="Ativar / Desativar Bluetooth"
T_M_SCAN="Escanear e Conectar"
T_M_KNOWN="Dispositivos Conhecidos"
T_M_FORGET="Esquecer um Dispositivo"
T_M_QUIT="Sair"
T_FIXING_AUDIO="Corrigindo protocolos de audio..."
T_PAIRING="Pareamento em curso..."
T_INTERNET="Internet necessaria"
T_ACTIVE="Uma conexao de internet ativa e necessaria para instalar componentes"
T_UPDATE="Atualizando listas de pacotes..."
T_PACKAGE="Instalando"
T_COMPLETE="Instalacao concluida !"
T_DEPS="Dependencias"
T_INIT="Inicializando..."
T_ON="LIGADO"
T_OFF="DESLIGADO"
T_SCAN_INIT="Inicializando Bleutooth..."
T_SCAN_PROCESS="Digitalizacao de ondas de radio..."
T_SCAN_RESOLV="Resolvendo nomes..."
T_SCAN_START="Iniciando escaneamento..."
T_CONN_TITLE="Conexao"
T_PROCESS="Processando..."
T_POWERING="Ligando adaptador..."
T_SYSTEM_FIX="Aplicando correcoes do sistema..."
T_DEV_DEFAULT="Dispositivo"
T_M_DISCONNECT="Desconectar um dispositivo"
T_DISCONNECTED="Desconectado"
T_REBOOT_TITLE="Reinicio necessario"
T_REBOOT_MSG="Instalacao concluida! Um reinicio e necessario para ativar todos os componentes Bluetooth.\n\nReiniciar agora?"

# --- ITALIANO (IT) ---
elif [[ "$SYSTEM_LANG" == *"it"* ]]; then
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition di Jason"
T_STARTING="Avvio di Bluetooth Manager dArkOs Edition ...\nAttendere prego."
T_ERR_TITLE="Errore"
T_STOPPING="Arresto Bluetooth..."
T_STARTING_BT="Avvio Bluetooth..."
T_ACTION="Azione"
T_BT_DISABLED="Bluetooth disattivato.\nAttivarlo prima."
T_SCAN_TITLE="Scansione"
T_NO_DEVICE="Nessun dispositivo rilevato."
T_INFO="Info"
T_NEARBY="Bluetooth vicini"
T_BACK="Indietro"
T_CHOOSE_DEV="Scegli un dispositivo:"
T_SUCCESS="Successo"
T_CONNECTED="e connesso"
T_FAILED="Fallito"
T_FAIL_CONNECT="Impossibile connettersi a"
T_FAIL_MSG="Assicurarsi che il dispositivo sia in modalita accoppiamento."
T_NO_KNOWN="Nessun dispositivo noto."
T_KNOWN_DEV="Dispositivi Noti"
T_CONNECT_TO="Connetti a:"
T_CONNECTING_TO="Connessione a"
T_NOTHING_DEL="Nulla da eliminare."
T_DELETE_TITLE="Elimina"
T_CHOOSE_DEL="Scegli dispositivo da dimenticare:"
T_FORGOTTEN="Dispositivo dimenticato."
T_MAIN_TITLE="Menu Principale"
T_QUIT="Esci"
T_STATUS="Stato Bluetooth"
T_CONN_TO="Connesso a"
T_NONE="Nessuno"
T_M_TOGGLE="Attiva / Disattiva Bluetooth"
T_M_SCAN="Scansiona e Connetti"
T_M_KNOWN="Dispositivi Noti"
T_M_FORGET="Dimentica un Dispositivo"
T_M_QUIT="Esci"
T_FIXING_AUDIO="Correzione protocolli audio..."
T_PAIRING="Accoppiamento in corso..."
T_INTERNET="Internet richiesto"
T_ACTIVE="E necessaria una connessione internet attiva per installare i componenti"
T_UPDATE="Aggiornamento delle liste dei pacchetti..."
T_PACKAGE="Installazione"
T_COMPLETE="Installazione completata !"
T_DEPS="Dipendenze"
T_INIT="Inizializzazione..."
T_ON="ACCESO"
T_OFF="SPENTO"
T_SCAN_INIT="Inizializzazione Bleutooth..."
T_SCAN_PROCESS="Scansione delle onde radio..."
T_SCAN_RESOLV="Risoluzione nomi..."
T_SCAN_START="Avvio scansione..."
T_CONN_TITLE="Connessione"
T_PROCESS="Elaborazione..."
T_POWERING="Accensione adattatore..."
T_DEV_DEFAULT="Dispositivo"
T_M_DISCONNECT="Disconnettere un dispositivo"
T_DISCONNECTED="Disconnesso"
T_REBOOT_TITLE="Riavvio richiesto"
T_REBOOT_MSG="Installazione completata! E necessario un riavvio per attivare tutti i componenti Bluetooth.\n\nRiavviare ora?"

# --- DEUTSCH (DE) ---
elif [[ "$SYSTEM_LANG" == *"de"* ]]; then
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition von Jason"
T_STARTING="Starte Bluetooth Manager dArkOs Edition ...\nBitte warten."
T_ERR_TITLE="Fehler"
T_STOPPING="Beende Bluetooth..."
T_STARTING_BT="Starte Bluetooth..."
T_ACTION="Aktion"
T_BT_DISABLED="Bluetooth deaktiviert.\nZuerst aktivieren."
T_SCAN_TITLE="Suche"
T_NO_DEVICE="Kein benanntes Geraet erkannt."
T_INFO="Info"
T_NEARBY="Bluetooth in der Naehe"
T_BACK="Zurueck"
T_CHOOSE_DEV="Waehle ein Geraet:"
T_SUCCESS="Erfolg"
T_CONNECTED="ist verbunden"
T_FAILED="Fehlgeschlagen"
T_FAIL_CONNECT="Verbindung fehlgeschlagen zu"
T_FAIL_MSG="Sicherstellen, dass das Geraet im Kopplungsmodus ist."
T_NO_KNOWN="Keine bekannten Geraete."
T_KNOWN_DEV="Bekannte Geraete"
T_CONNECT_TO="Verbinden mit:"
T_CONNECTING_TO="Verbinde mit"
T_NOTHING_DEL="Nichts zu loeschen."
T_DELETE_TITLE="Loeschen"
T_CHOOSE_DEL="Waehle das zu vergessende Geraet:"
T_FORGOTTEN="Geraet vergessen."
T_MAIN_TITLE="Hauptmenue"
T_QUIT="Beenden"
T_STATUS="Bluetooth-Status"
T_CONN_TO="Verbunden mit"
T_NONE="Keines"
T_M_TOGGLE="Bluetooth aktivieren / deaktivieren"
T_M_SCAN="Suchen und Verbinden"
T_M_KNOWN="Bekannte Geraete"
T_M_FORGET="Ein Geraet vergessen"
T_M_QUIT="Beenden"
T_FIXING_AUDIO="Audio-Protokolle werden korrigiert..."
T_PAIRING="Kopplung laeuft..."
T_INTERNET="Internet erforderlich"
T_ACTIVE="Eine aktive Internetverbindung ist erforderlich um Komponenten zu installieren"
T_UPDATE="Aktualisierung der Paketlisten..."
T_PACKAGE="Installation"
T_COMPLETE="Installation abgeschlossen !"
T_DEPS="Abhaengigkeiten"
T_INIT="Initialisierung..."
T_ON="AN"
T_OFF="AUS"
T_SCAN_INIT="Bleutooth wird initialisiert..."
T_SCAN_PROCESS="Abtasten der Atherwellen..."
T_SCAN_RESOLV="Geraetenamen werden aufgeloest..."
T_SCAN_START="Suchvorgang startet..."
T_CONN_TITLE="Verbindung"
T_PROCESS="Verarbeitung..."
T_POWERING="Adapter wird eingeschaltet..."
T_SYSTEM_FIX="Systemkorrekturen werden angewendet..."
T_DEV_DEFAULT="Geraet"
T_M_DISCONNECT="Geraet trennen"
T_DISCONNECTED="Getrennt"
T_REBOOT_TITLE="Neustart erforderlich"
T_REBOOT_MSG="Installation abgeschlossen! Ein Neustart ist erforderlich, um alle Bluetooth-Komponenten zu aktivieren.\n\nJetzt neu starten?"

# --- POLSKI (PL) ---
elif [[ "$SYSTEM_LANG" == *"pl"* ]]; then
T_BACKTITLE="R36s Bluetooth Manager dArkOs Edition przez Jasona"
T_STARTING="Uruchamianie Bluetooth Manager dArkOs Edition ...\nProsze czekac."
T_ERR_TITLE="Blad"
T_STOPPING="Zatrzymywanie Bluetooth..."
T_STARTING_BT="Uruchamianie Bluetooth..."
T_ACTION="Akcja"
T_BT_DISABLED="Bluetooth wylaczony.\nNajpierw go wlacz."
T_SCAN_TITLE="Skanowanie"
T_NO_DEVICE="Nie wykryto zadnego urzadzenia."
T_INFO="Info"
T_NEARBY="Bluetooth w poblizu"
T_BACK="Wstecz"
T_CHOOSE_DEV="Wybierz urzadzenie:"
T_SUCCESS="Sukces"
T_CONNECTED="jest polaczony"
T_FAILED="Nieudane"
T_FAIL_CONNECT="Nie mozna polaczyc z"
T_FAIL_MSG="Upewnij sie, ze urzadzenie jest w trybie parowania."
T_NO_KNOWN="Brak znanych urzadzen."
T_KNOWN_DEV="Znane urzadzenia"
T_CONNECT_TO="Polacz z:"
T_CONNECTING_TO="Laczenie z"
T_NOTHING_DEL="Nic do usuniecia."
T_DELETE_TITLE="Usun"
T_CHOOSE_DEL="Wybierz urzadzenie do zapomnienia:"
T_FORGOTTEN="Urzadzenie zapomniane."
T_MAIN_TITLE="Menu glowne"
T_QUIT="Wyjscie"
T_STATUS="Status Bluetooth"
T_CONN_TO="Polaczono z"
T_NONE="Brak"
T_M_TOGGLE="Wlacz / Wylacz Bluetooth"
T_M_SCAN="Skanuj i polacz"
T_M_KNOWN="Znane urzadzenia"
T_M_FORGET="Zapomnij urzadzenie"
T_M_QUIT="Wyjscie"
T_FIXING_AUDIO="Naprawa protokolow audio..."
T_PAIRING="Parowanie w toku..."
T_INTERNET="Internet wymagany"
T_ACTIVE="Aktywne polaczenie internetowe jest wymagane do zainstalowania komponentow"
T_UPDATE="Aktualizowanie list pakietow..."
T_PACKAGE="Instalowanie"
T_COMPLETE="Instalacja zakonczona !"
T_DEPS="Zaleznosci"
T_INIT="Inicjalizowanie..."
T_ON="WLACZONE"
T_OFF="WYLACZONE"
T_SCAN_INIT="Inicjowanie Bleutooth..."
T_SCAN_PROCESS="Skanowanie fal radiowych..."
T_SCAN_RESOLV="Rozpoznawanie nazw..."
T_SCAN_START="Uruchamianie skanowania..."
T_CONN_TITLE="Polaczenie"
T_PROCESS="Przetwarzanie..."
T_POWERING="Wlaczanie adaptera..."
T_SYSTEM_FIX="Stosowanie poprawek systemowych..."
T_DEV_DEFAULT="Urzadzenie"
T_M_DISCONNECT="Rozlaczyc urzadzenie"
T_DISCONNECTED="Rozlaczono"
T_REBOOT_TITLE="Wymagane ponowne uruchomienie"
T_REBOOT_MSG="Instalacja zakonczona! Wymagane jest ponowne uruchomienie, aby aktywowac wszystkie komponenty Bluetooth.\n\nUruchomic ponownie teraz?"
fi

# --- Gestion de l'affichage ---
printf "\033c" > "$CURR_TTY"
printf "\e[?25l" > "$CURR_TTY"
dialog --clear

# --- FONT SELECTION ---
if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz
else
    setfont /usr/share/consolefonts/Lat7-Terminus16.psf.gz
fi

pkill -9 -f gptokeyb || true
pkill -9 -f osk.py || true

printf "\033c" > "$CURR_TTY"
printf "$T_STARTING" > "$CURR_TTY"
sleep 1

# --- Variables globales ---
height="16"
width="50"
list_height="8"
BACKTITLE="$T_BACKTITLE"

# --- Etat du Bluetooth ---
GetPowerStatus() {
    if rfkill list bluetooth | grep -q "Soft blocked: yes"; then return 1; fi
    if ! systemctl is-active --quiet bluetooth; then return 1; fi
    if ! echo "show" | bluetoothctl | sed 's/\x1b\[[0-9;]*m//g' | grep -q "Powered: yes"; then return 1; fi
    return 0
}

# --- Nom du peripherique connecté ---
GetConnectedName() {
    local found_name=""
    found_name=$(bluetoothctl devices | while read -r _ mac name; do
        if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
            echo "$name"
            break
        fi
    done)
    echo "${found_name:-$T_NONE}"
}

# --- Vérification des dependances ---
CheckDeps() {
    [ -f "$INSTALLED_FLAG" ] && return
    
    local REQUIRED_PACKAGES=("bluez" "pulseaudio-module-bluetooth" "pulseaudio" "alsa-utils" "evtest" "libasound2-plugins" "dbus-user-session" "dbus-x11" "bluez-tools")
    local MISSING_PACKAGES=()
    
    for pkg in "${REQUIRED_PACKAGES[@]}"; do
        if ! dpkg -s "$pkg" &>/dev/null; then MISSING_PACKAGES+=("$pkg"); fi
    done

    if [[ ${#MISSING_PACKAGES[@]} -gt 0 ]]; then
        if ! ping -c 1 -W 3 8.8.8.8 &>/dev/null; then
            dialog --backtitle "$BACKTITLE" --title "$T_INTERNET" --msgbox "\n$T_ACTIVE:\n\n${MISSING_PACKAGES[*]}" 12 60 > "$CURR_TTY"
            ExitMenu
        fi

        (
            current_p=0

            # --- Fonction pour faire progresser la barre pendant qu'une commande tourne ---
            progress_while_running() {
                local pid=$1
                local target=$2
                local msg=$3

                while kill -0 $pid 2>/dev/null; do
                    if [ $current_p -lt $target ]; then
                        current_p=$((current_p + 1))
                        echo "$current_p"
                        echo "XXX"; echo "$msg"; echo "XXX"
                    fi
                    sleep 0.15 
                done

                current_p=$target
                echo "$current_p"
                echo "XXX"; echo "$msg"; echo "XXX"
            }

            # Mise à jour des dépôts
            apt-get update -y >/dev/null 2>&1 &
            progress_while_running $! 25 "$T_UPDATE"

            # Installation des paquets
            TOTAL=${#MISSING_PACKAGES[@]}
            COUNT=0
            for pkg in "${MISSING_PACKAGES[@]}"; do
                COUNT=$((COUNT + 1))
               
                start_section=$(( 25 + ( (COUNT - 1) * 70 / TOTAL ) ))
                end_section=$(( 25 + ( COUNT * 70 / TOTAL ) ))
                
                DEBIAN_FRONTEND=noninteractive apt-get install -y "$pkg" >/dev/null 2>&1 &
                progress_while_running $! $end_section "$T_PACKAGE $pkg ($COUNT/$TOTAL)..."
            done

            # Finalisation
            while [ $current_p -lt 100 ]; do
                current_p=$((current_p + 1))
                echo "$current_p"
                echo "XXX"; echo "$T_COMPLETE"; echo "XXX"
                sleep 0.05
            done
            
        ) | dialog --backtitle "$BACKTITLE" --title "$T_DEPS" --gauge "\n$T_INIT" 8 60 0 > "$CURR_TTY"
    fi
}

# --- Configuration du volume ---
FixVolumeScript() {
    cat <<'EOF' | sudo tee /usr/local/bin/bt-volume-monitor.sh > /dev/null
#!/bin/bash

PA_CMD="pactl --server=unix:/var/run/pulse/native"
LOCK="/tmp/vol_busy"
rm -f "$LOCK"

# Attente que l'audio soit prêt
until [ -S /var/run/pulse/native ] && $PA_CMD stat >/dev/null 2>&1; do
    sleep 0.5
done

# Détection des touches
EV_PATH="/dev/input/event3"
[ ! -e "$EV_PATH" ] && EV_PATH="/dev/input/$(grep -E 'Handlers|Name' /proc/bus/input/devices | grep -A1 "odroidgo3-keys" | grep -oE 'event[0-9]+' | head -n1)"

stdbuf -oL evtest "$EV_PATH" | while read line; do
 
    if [[ "$line" == *"value 0"* ]]; then
        rm -f "$LOCK"
        continue
    fi

    if [[ "$line" == *"KEY_VOLUME"* ]]; then
        # On récupère le volume actuel
        CUR_VOL=$($PA_CMD list sinks | grep 'Volume:' | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
        
        # On détermine la direction
        [[ "$line" == *"KEY_VOLUMEUP"* ]] && DIR="+" || DIR="-"

        # Sécurité pour ne pas dépasser 0-100%
        if [[ "$DIR" == "+" && "$CUR_VOL" -ge 100 ]]; then
            $PA_CMD set-sink-volume @DEFAULT_SINK@ 100%
            continue
        fi
        if [[ "$DIR" == "-" && "$CUR_VOL" -le 0 ]]; then
            $PA_CMD set-sink-volume @DEFAULT_SINK@ 0%
            continue
        fi

        # Gestion de la vitesse selon le type d'appui
        if [[ "$line" == *"value 1"* ]]; then
            # Appui simple
            STEP="2%"
            $PA_CMD set-sink-volume @DEFAULT_SINK@ ${DIR}${STEP}
            amixer -q sset Master ${STEP}${DIR} 2>/dev/null
            
        elif [[ "$line" == *"value 2"* ]]; then
            # Appui prolongé
            if [ ! -f "$LOCK" ]; then
                touch "$LOCK"
                STEP="2%"
                $PA_CMD set-sink-volume @DEFAULT_SINK@ ${DIR}${STEP}
                amixer -q sset Master ${STEP}${DIR} 2>/dev/null
                
                (sleep 0.07; rm -f "$LOCK") &
            fi
        fi
    fi
done
EOF
    sudo chmod +x /usr/local/bin/bt-volume-monitor.sh
}

# --- Configuration du Bluetooth ---
FixBluetoothConfig() {
    dialog --backtitle "$BACKTITLE" --title "$T_INFO" --infobox "\n$T_SYSTEM_FIX" 5 50 > "$CURR_TTY"

    REAL_BT_PATH=$(find /usr -name bluetoothd -type f -executable | head -n 1)
    
    if [ -n "$REAL_BT_PATH" ]; then
        sudo sed -i "s|^ExecStart=.*|ExecStart=$REAL_BT_PATH --noplugin=sap|" /lib/systemd/system/bluetooth.service
    fi

    # Groupes et Permissions
    for u in ark root pulse; do
        sudo usermod -aG pulse-access,audio,bluetooth,input $u 2>/dev/null
    done

    # Config PulseAudio
    cat <<EOF | sudo tee /etc/pulse/system.pa > /dev/null
load-module module-device-restore
load-module module-stream-restore
load-module module-card-restore
load-module module-augment-properties
load-module module-udev-detect
load-module module-alsa-sink device=default sink_name=internal_speaker
load-module module-native-protocol-unix auth-anonymous=1
load-module module-rescue-streams
load-module module-always-sink
load-module module-intended-roles
load-module module-suspend-on-idle
load-module module-bluetooth-policy
load-module module-bluetooth-discover
load-module module-switch-on-connect
EOF

    # Service PulseAudio
    cat <<EOF | sudo tee /etc/systemd/system/pulseaudio.service > /dev/null
[Unit]
Description=PulseAudio System Daemon
After=bluetooth.service
Wants=bluetooth.service

[Service]
Type=simple
ExecStart=/usr/bin/pulseaudio --system --realtime --disallow-exit --no-cpu-limit
Restart=always
RestartSec=5
Nice=-5

[Install]
WantedBy=multi-user.target
EOF

    # Service Volume
    cat <<EOF | sudo tee /etc/systemd/system/bt-volume-monitor.service > /dev/null
[Unit]
Description=R36S Volume Buttons Monitor
After=pulseaudio.service

[Service]
Type=simple
ExecStartPre=/bin/chmod 666 /dev/input/event3
ExecStart=/usr/local/bin/bt-volume-monitor.sh
Restart=always
RestartSec=2
User=root
Nice=-15

[Install]
WantedBy=multi-user.target
EOF

    # Configuration du Bluetooth 
    sudo chmod 755 /etc/bluetooth
    cat <<EOF | sudo tee /etc/bluetooth/main.conf > /dev/null
[General]
JustWorksRepairing = always
AutoEnable = true
FastConnectable = true
ReconnectAttempts = 7
ReconnectInterval = 5
EOF
    
# --- Configuration audio retroArch et retroArch32 ---
    local RA_CONFIGS=("/home/ark/.config/retroarch/retroarch.cfg" "/home/ark/.config/retroarch32/retroarch.cfg")
    
    for conf in "${RA_CONFIGS[@]}"; do
        if [ -f "$conf" ]; then
            if grep -q "^audio_driver =" "$conf"; then
                sudo sed -i 's/^audio_driver = .*/audio_driver = "sdl2"/' "$conf"
            else
        echo 'audio_driver = "sdl2"' | sudo tee -a "$conf" > /dev/null
            fi
        fi
    done
    
    FixVolumeScript

    sudo systemctl daemon-reload
    sudo systemctl unmask bluetooth.service 2>/dev/null
    sudo systemctl enable bluetooth.service
    sudo systemctl enable pulseaudio.service
    sudo systemctl enable bt-volume-monitor.service
    
    # Relance immédiate pour tester
    sudo systemctl restart bluetooth.service
    sudo systemctl restart pulseaudio.service
    sudo systemctl restart bt-volume-monitor.service
}

# --- Patch pour l'audio ---
ApplyAudioFix() {
    local PA_CMD="pactl --server=unix:/var/run/pulse/native"
    
    sleep 2

    # On cherche si un sink Bluetooth est présent
    local BT_SINK=$($PA_CMD list short sinks | grep "bluez_sink" | awk '{print $2}')

    if [ -n "$BT_SINK" ]; then
        # On définit le Bluetooth comme sortie par défaut
        $PA_CMD set-default-sink "$BT_SINK" 70% >/dev/null 2>&1

        local CARD=$($PA_CMD list short cards | grep "bluez_card" | awk '{print $2}')
        if [ -n "$CARD" ]; then
            $PA_CMD set-card-profile "$CARD" a2dp_sink >/dev/null 2>&1
        fi

        $PA_CMD set-sink-volume "$BT_SINK" 70% >/dev/null 2>&1
    else
        # On force le retour sur les HP internes
        $PA_CMD set-default-sink internal_speaker >/dev/null 2>&1
        $PA_CMD set-sink-mute internal_speaker 0 >/dev/null 2>&1
    fi

    # On déplace tous les flux audio en cours vers la nouvelle sortie
    local DEFAULT_SINK=$($PA_CMD info | grep "Default Sink" | awk '{print $3}')
    for stream in $($PA_CMD list short sink-inputs | awk '{print $1}'); do
        $PA_CMD move-sink-input "$stream" "$DEFAULT_SINK" >/dev/null 2>&1
    done
}

# --- Permission des groupes ---
EnsurePermissions() {
    if [ ! -f "$INSTALLED_FLAG" ]; then
        # On ajoute ark et root aux groupes nécessaires
        local groups=("bluetooth" "lp" "pulse" "pulse-access" "input" "audio")
        for g in "${groups[@]}"; do usermod -aG "$g" ark; done
        for g in "${groups[@]}"; do usermod -aG "$g" root; done
        
        # On ajoute l'utilisateur système 'pulse' au groupe 'audio'
        sudo usermod -aG audio pulse 2>/dev/null
        sudo usermod -aG input pulse
        
        FixBluetoothConfig
        touch "$INSTALLED_FLAG"
        if dialog --backtitle "$BACKTITLE" --title "$T_REBOOT_TITLE" --yesno "\n$T_REBOOT_MSG" 10 50 > "$CURR_TTY"; then
            reboot
        fi
    fi
}

# --- Remets le son sur les hp
ForceInternalAudio() {
    local PA_CMD="pactl --server=unix:/var/run/pulse/native"

    $PA_CMD set-default-sink internal_speaker >/dev/null 2>&1

    $PA_CMD set-sink-mute internal_speaker 0 >/dev/null 2>&1
    $PA_CMD set-sink-volume internal_speaker 75% >/dev/null 2>&1
    
    # On déplace les sons en cours vers le haut-parleur
    for stream in $($PA_CMD list short sink-inputs | awk '{print $1}'); do
        $PA_CMD move-sink-input "$stream" internal_speaker >/dev/null 2>&1
    done
}

# --- Activer/Desactiver le Bluetooth ---
ToggleBT() {
  if GetPowerStatus; then
      dialog --backtitle "$BACKTITLE" --title "$T_ACTION" --infobox "\n  $T_STOPPING" 5 35 > "$CURR_TTY"
       bluetoothctl power off > /dev/null 2>&1
       systemctl stop bluetooth > /dev/null 2>&1
    ForceInternalAudio
  else
      dialog --backtitle "$BACKTITLE" --title "$T_ACTION" --infobox "\n  $T_POWERING" 5 35 > "$CURR_TTY"
       rfkill unblock bluetooth > /dev/null 2>&1
       systemctl start bluetooth > /dev/null 2>&1
       bluetoothctl power on > /dev/null 2>&1
  fi
    ApplyAudioFix
}

# --- Scan et connection ---
ScanAndConnect() {
  if ! GetPowerStatus; then
      dialog --backtitle "$BACKTITLE" --title "$T_ERR_TITLE" --msgbox "\n $T_BT_DISABLED" 8 30 > "$CURR_TTY"
      return
  fi

  rm -f /tmp/bt_scan_results.txt
  
  (
    echo "0"; echo "XXX"; echo "$T_POWERING"; echo "XXX"
    bluetoothctl power on > /dev/null 2>&1
    bluetoothctl agent on > /dev/null 2>&1
    bluetoothctl default-agent > /dev/null 2>&1
    bluetoothctl pairable on > /dev/null 2>&1
    bluetoothctl discoverable on > /dev/null 2>&1
    
    SCAN_TIME=10
    bluetoothctl --timeout $SCAN_TIME scan on > /tmp/bt_scan_results.txt 2>&1 &
    SCAN_PID=$!
    
    for ((i=0; i<=SCAN_TIME*10; i++)); do
        PERCENT=$(( i * 100 / (SCAN_TIME * 10) ))
        if [ $i -lt 30 ]; then MSG="$T_SCAN_INIT"; 
        elif [ $i -lt 80 ]; then MSG="$T_SCAN_PROCESS"; 
        else MSG="$T_SCAN_RESOLV"; fi
        
        echo "$PERCENT"
        echo "XXX"; echo "$MSG"; echo "XXX"
        sleep 0.1
    done
    wait $SCAN_PID
    bluetoothctl scan off > /dev/null 2>&1
    echo "100"
  ) | dialog --backtitle "$BACKTITLE" --title "$T_SCAN_TITLE" --gauge "\n$T_SCAN_START" 8 45 0 > "$CURR_TTY"

  bluetoothctl devices > /tmp/bt_devices_list.txt
  unset coptions
  while read -r line; do
    if [[ "$line" == *"Device"* ]]; then
        # Extraction propre de la MAC et du Nom
        local mac=$(echo "$line" | awk '{print $2}')
        local name=$(echo "$line" | cut -d ' ' -f 3-)
        
        # Nettoyage des espaces
        name=$(echo "$name" | xargs)

        # --- Filtres ---
        local valid=true
        
        # Pas de nom vide
        if [ -z "$name" ] || [ "$name" == "$line" ]; then valid=false; fi
        # Le nom ne doit pas être l'adresse MAC
        if [[ "$name" =~ ^([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}$ ]]; then valid=false; fi
        # Filtre de messages d'erreur système
        if [[ "$name" == *"rguments"* ]] || [[ "$name" == *"not available"* ]]; then valid=false; fi

        if [ "$valid" = true ]; then
            local display_name="$name"
            # On vérifie si déjà connecté 
            if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                display_name="\Z5* $name $T_CONNECTED *\Zn"
            fi
            coptions+=("$mac" "$display_name")
        fi
    fi
  done < /tmp/bt_devices_list.txt

  if [ ${#coptions[@]} -eq 0 ]; then
     dialog --backtitle "$BACKTITLE" --title "$T_INFO" --msgbox "\n $T_NO_DEVICE" 8 40 > "$CURR_TTY"
     return
  fi

  cselection=$(dialog --colors --backtitle "$BACKTITLE" --title "$T_NEARBY" --cancel-label "$T_BACK" --menu "$T_CHOOSE_DEV" $height $width $list_height "${coptions[@]}" 2>&1 > "$CURR_TTY")
  [ $? -eq 0 ] && ConnectProcess "$cselection"
}

# --- Stabilise la connexion
is_connected_stable() {
    local mac="$1"
    local PA_CMD="pactl --server=unix:/var/run/pulse/native"

    sleep 1

    if bluetoothctl info "$mac" | sed 's/\x1b\[[0-9;]*m//g' | grep -q "Connected: yes"; then
        return 0
    fi

    if $PA_CMD list short sinks | grep -q "bluez_sink"; then
        return 0
    fi
    
    return 1
}

# --- Connexion ---
ConnectProcess() {
    systemctl stop bluetooth-icon-updater.service || true
  local mac="$1"
  local name=$(bluetoothctl info "$mac" | sed 's/\x1b\[[0-9;]*m//g' | sed -n 's/.*Alias: //p' | xargs)
  [ -z "$name" ] && name="$T_DEV_DEFAULT"

  (
    current_p=0
    smooth_bar() {
      local target=$1
      local msg=$2
      while [ $current_p -lt $target ]; do
        current_p=$((current_p + 1))
        echo "$current_p"; echo "XXX"; echo "$msg"; echo "XXX"
        sleep 0.04
      done
    }

    # Confiance et Appairage
    smooth_bar 25 "$T_PROCESS..."
    bluetoothctl trust "$mac" >/dev/null 2>&1
    
    smooth_bar 50 "$T_PAIRING..."
    bluetoothctl pair "$mac" >/dev/null 2>&1
    sleep 0.5

    # Connexion
    smooth_bar 75 "$T_CONNECTING_TO $name..."
    bluetoothctl connect "$mac" >/dev/null 2>&1
    sleep 0.5

    # Patch audio
    smooth_bar 100 "$T_FIXING_AUDIO..."
    ApplyAudioFix
    ) | dialog --backtitle "$BACKTITLE" --title "$T_CONN_TITLE" --gauge "" 8 50 0 > "$CURR_TTY"
  
  if is_connected_stable "$mac"; then
      dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $name $T_CONNECTED\n" 7 $width > "$CURR_TTY"
  else
      dialog --backtitle "$BACKTITLE" --title "$T_FAILED" --msgbox "\n $T_FAIL_CONNECT $name.\n\n $T_FAIL_MSG" 12 $width > "$CURR_TTY"
  fi
    systemctl start bluetooth-icon-updater.service || true
}

# --- Deconnection ---
DisconnectProcess() {
  unset poptions
  while read -r line; do
      local mac=$(echo "$line" | awk '{print $2}')
      local name=$(echo "$line" | cut -d ' ' -f 3-)
      
      # Vérifie si ce périphérique est connecté
      if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
          poptions+=("$mac" "$name")
      fi
  done < <(bluetoothctl devices)

  # Si rien n'est connecté
  if [ ${#poptions[@]} -eq 0 ]; then
     dialog --backtitle "$BACKTITLE" --title "$T_INFO" --msgbox "\n $T_NONE $T_CONNECTED" 7 35 > "$CURR_TTY"
     return
  fi
 
  pselection=$(dialog --backtitle "$BACKTITLE" --title "$T_M_DISCONNECT" --menu "$T_CHOOSE_DEV" 15 50 8 "${poptions[@]}" 2>&1 > "$CURR_TTY")
  [ $? -ne 0 ] && return

  local sel_name=$(bluetoothctl info "$pselection" | sed -n 's/.*Alias: //p' | xargs)
  [ -z "$sel_name" ] && sel_name="$T_DEV_DEFAULT"

  (
    echo "20"; echo "XXX"; echo "$T_PROCESS"; echo "XXX"
    bluetoothctl disconnect "$pselection" > /dev/null 2>&1
    
    echo "80"; echo "XXX"; echo "$T_PROCESS"; echo "XXX"
    
    ForceInternalAudio
    echo "100"
  ) | dialog --backtitle "$BACKTITLE" --title "$T_CONN_TITLE" --gauge "\n $T_PROCESS" 8 50 0 > "$CURR_TTY"
    
  if bluetoothctl info "$pselection" | grep -q "Connected: no"; then
      dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $sel_name $T_DISCONNECTED" 7 40 > "$CURR_TTY"
  else
      dialog --backtitle "$BACKTITLE" --title "$T_FAILED" --msgbox "\n Impossible de deconnecter $sel_name" 7 40 > "$CURR_TTY"
  fi
}

# --- Listes des peripherique connu ---
ListKnownAndConnect() {
    unset koptions
    while read -r line; do
        mac=$(echo "$line" | awk '{print $2}')
        name=$(echo "$line" | cut -d ' ' -f 3-)
        koptions+=("$mac" "$name")
    done < <(bluetoothctl devices)

    if [ ${#koptions[@]} -eq 0 ]; then
       dialog --backtitle "$T_BACKTITLE" --title "$T_INFO" --msgbox "\n $T_NO_KNOWN" 7 33 > "$CURR_TTY"
       return
    fi
  
    kselection=$(dialog --backtitle "$T_BACKTITLE" --title "$T_KNOWN_DEV" --menu "$T_CONNECT_TO" 15 50 8 "${koptions[@]}" 2>&1 > "$CURR_TTY")
    [ $? -eq 0 ] && ConnectProcess "$kselection"
}

# --- Supprimer un peripherique ---
DeleteDevice() {
  unset doptions
  while read -r line; do
        mac=$(echo "$line" | awk '{print $2}')
        name=$(echo "$line" | cut -d ' ' -f 3-)
        doptions+=("$mac" "$name")
  done < <(bluetoothctl devices)

  if [ ${#doptions[@]} -eq 0 ]; then
     dialog --backtitle "$T_BACKTITLE" --title "$T_INFO" --msgbox "\n $T_NOTHING_DEL" 7 25 > "$CURR_TTY"
     return
  fi

  dselection=$(dialog --backtitle "$T_BACKTITLE" --title "$T_DELETE_TITLE" --menu "$T_CHOOSE_DEL" 15 50 8 "${doptions[@]}" 2>&1 > "$CURR_TTY")
  if [ $? -eq 0 ]; then
    bluetoothctl remove "$dselection" > /dev/null 2>&1
    dialog --backtitle "$T_BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $T_FORGOTTEN" 7 30 > "$CURR_TTY"
  fi
}

# --- Sortie ---
ExitMenu() {
    printf "\033c" > "$CURR_TTY"
    printf "\e[?25h" > "$CURR_TTY"
    pkill -f "gptokeyb" || true
    exit 0
}

# --- Menu principal ---
MainMenu() {
  CheckDeps
  EnsurePermissions
  
  while true; do
    if GetPowerStatus; then
        BT_STAT="\Z2$T_ON\Zn"; DEV_NAME="\Z4$(GetConnectedName)\Zn"
    else
        BT_STAT="\Z1$T_OFF\Zn"; DEV_NAME="$T_NONE"
    fi
    
    mainselection=$(dialog --colors --backtitle "$BACKTITLE" --title "$T_MAIN_TITLE" --cancel-label "$T_QUIT" \
    --menu "\n$T_STATUS : $BT_STAT\n$T_CONN_TO : $DEV_NAME\n " $height $width 8 \
    1 "$T_M_TOGGLE" \
    2 "$T_M_SCAN" \
    3 "$T_M_DISCONNECT" \
    4 "$T_M_KNOWN" \
    5 "$T_M_FORGET" \
    6 "$T_M_QUIT" 2>&1 > "$CURR_TTY")
    [ $? -ne 0 ] && ExitMenu
    case $mainselection in
        1) ToggleBT ;;
        2) ScanAndConnect ;;
        3) DisconnectProcess ;;
        4) ListKnownAndConnect ;;
        5) DeleteDevice ;;
        6) ExitMenu ;;
    esac
  done
}

# --- Initialisation & Polices ---
printf "\033c" > "$CURR_TTY"
printf "\e[?25l" > "$CURR_TTY"
if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz
else
    setfont /usr/share/consolefonts/Lat7-Terminus16.psf.gz
fi

pkill -9 -f gptokeyb || true
export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"
/opt/inttools/gptokeyb -1 "Bluetooth Manager.sh" -c "/opt/inttools/keys.gptk" > /dev/null 2>&1 &

trap ExitMenu EXIT

# --- Depart du script ---
MainMenu