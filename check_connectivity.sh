#!/bin/bash

# Fichier de log
logfile="connectivity_log.txt"

# Fonction pour tester la connectivité
check_connectivity() {
    # Liste des sites à tester
    local sites=("$@")

    # Efface le contenu du fichier de log
    > "$logfile"

    # Liste des sites à exclure
    local excluded_sites=("www.bing.com")

    for site in "${sites[@]}"
    do
        # Vérifie si le site fait partie des sites exclus
        if [[ " ${excluded_sites[@]} " =~ " ${site} " ]]; then
            echo "$(date): Le site $site est exclu de la vérification." | tee -a "$logfile"
            continue
        fi

        if ping -c 1 -W 1 "$site" > /dev/null 2>&1; then
            echo "$(date): Le site $site est accessible." | tee -a "$logfile"
        else
            echo "$(date): ATTENTION ! Le site $site n'est pas accessible." | tee -a "$logfile"
        fi
    done
}

# Appel de la fonction de vérification de la connectivité
echo "Veuillez entrer les URLs des sites à vérifier, séparés par des espaces:"
read -a sites
check_connectivity "${sites[@]}"