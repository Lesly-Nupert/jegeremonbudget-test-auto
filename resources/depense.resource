*** Settings ***
Library    SeleniumLibrary
Resource   commun.resource

*** Variables ***
# Locators 
${CHAMP_NOM_DEPENSE}    id=transaction_name
${CHAMP_MONTANT}    id=amount
${BOUTON_CREER_DEPENSE}    //button[normalize-space()='Ajouter la dépense']
${MESSAGE_ALERT}    //div[@role='alert']
${H1_AJOUTER_DEPENSE}    //h1[normalize-space()='Ajouter une dépense']
${LIEN_AJOUTER_UNE_DEPENSE}    //a[normalize-space()='Ajouter une dépense']
${LIEN_COMPTE_CHOISI_POUR_LE_TEST}    //p[normalize-space()='Compte Test']

# Messages de l'application (succès ET erreurs) 
# Le Mot Clé "Vérifier Formulaire Ajout Dépense Non Soumis" gère les messages d'erreur HTML natifs
${MSG_AJOUT_DEPENSE_RÉUSSI}    Dépense ajoutée avec succès !
${MSG_NOM_DEPENSE_INVALIDE}    ERREUR Le nom de la dépense ne doit contenir que des lettres et aucun espace avant ou après.

*** Keywords ***
Aller Sur Le Formulaire D'ajout D'une Dépense
    Wait Until Element Is Visible    ${LIEN_AJOUTER_UNE_DEPENSE}    timeout=10s
    Click Element    ${LIEN_AJOUTER_UNE_DEPENSE}
    Wait Until Element Is Visible    ${CHAMP_NOM_DEPENSE}    timeout=10s

Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Wait Until Element Is Visible    ${LIEN_COMPTE_CHOISI_POUR_LE_TEST}    timeout=10s
    Click Element    ${LIEN_COMPTE_CHOISI_POUR_LE_TEST}
    Wait Until Element Is Visible    ${LIEN_AJOUTER_UNE_DEPENSE}    timeout=10s
    Click Element    ${LIEN_AJOUTER_UNE_DEPENSE}
    Wait Until Element Is Visible    ${CHAMP_NOM_DEPENSE}    timeout=10s

Remplir Le Formulaire De Création D'Une Dépense
    [Arguments]    ${nom_depense}   ${montant}
    Input Text    ${CHAMP_NOM_DEPENSE}    ${nom_depense}
    Input Text    ${CHAMP_MONTANT}    ${montant}

Valider La Création D'Une Dépense
    # ✅ "${status}    Run Keyword And Return Status"
    # Vérifie que le message d'alerte est affiché et récupère son statut mais sans faire échouer le test si le message n'est pas visible (Solution pour contourner les messages d'erreur HTML natifs non visibles dans le DOM)
    Click Button    ${BOUTON_CREER_DEPENSE}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=5s

Vérifier Création D'une Dépense Réussie
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_AJOUT_DEPENSE_RÉUSSI}

Vérifier Message D'erreur Nom Dépense Invalide
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_NOM_DEPENSE_INVALIDE}

Vérifier Formulaire Ajout Dépense Non Soumis
    # ✅ Contourne les messages d'erreur HTML natifs qui ne sont pas gérés par l'application et qui ne sont pas affichés dans le DOM
    Page Should Contain Element    ${CHAMP_NOM_DEPENSE}
    Page Should Contain Element    ${H1_AJOUTER_DEPENSE}

# Vérifier Solde Du Compte - ⚠️ Ce mot clé est dans commun.resource

   
   