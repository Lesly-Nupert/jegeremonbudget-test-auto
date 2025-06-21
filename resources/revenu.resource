*** Settings ***
Library    SeleniumLibrary
Resource   commun.resource

*** Variables ***
# Locators 
${CHAMP_NOM_REVENU}    id=transaction_name
${CHAMP_MONTANT}    id=amount
${BOUTON_CREER_REVENU}    //button[normalize-space()='Ajouter le revenu']
${MESSAGE_ALERT}    //div[@role='alert']
${H1_AJOUTER_REVENU}    //h1[normalize-space()='Ajouter un revenu']
${BALANCE}    p[aria-label='Balance du compte'] span
${LIEN_AJOUTER_UN_REVENU}    //a[normalize-space()='Ajouter un revenu']
${LIEN_COMPTE_CHOISI_POUR_LE_TEST}    //p[normalize-space()='Compte Test']

# Messages de l'application (succès ET erreurs) 
${MSG_AJOUT_REVENU_RÉUSSI}    Revenu ajouté avec succès !
${MSG_NOM_REVENU_INVALIDE}    ERREUR Le nom du revenu ne doit contenir que des lettres et aucun espace avant ou après.

*** Keywords ***
Aller Sur Le Formulaire D'ajout D'un Revenu
    Wait Until Element Is Visible    ${LIEN_COMPTE_CHOISI_POUR_LE_TEST}    timeout=10s
    Click Element    ${LIEN_COMPTE_CHOISI_POUR_LE_TEST}
    Wait Until Element Is Visible    ${LIEN_AJOUTER_UN_REVENU}    timeout=10s
    Click Element    ${LIEN_AJOUTER_UN_REVENU}
    Wait Until Element Is Visible    ${CHAMP_NOM_REVENU}    timeout=10s

Remplir Le Formulaire De Création D'Un Revenu
    [Arguments]    ${nom_revenu}   ${montant}
    Input Text    ${CHAMP_NOM_REVENU}    ${nom_revenu}
    Input Text    ${CHAMP_MONTANT}    ${montant}

Valider La Création D'Un Revenu
    # ✅ "${status}    Run Keyword And Return Status"
    # Vérifie que le message d'alerte est affiché et récupère son statut mais sans faire échouer le test si le message n'est pas visible (Solution pour contourner les messages d'erreur HTML natifs non visibles dans le DOM)
    Click Button    ${BOUTON_CREER_REVENU}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=5s

Vérifier Création D'un Revenu Réussie
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_AJOUT_REVENU_RÉUSSI}

Vérifier Message D'erreur Nom Revenu Invalide
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_NOM_REVENU_INVALIDE}

Vérifier Formulaire Ajout Revenu Non Soumis
    # ✅ Contourne les messages d'erreur HTML natifs qui ne sont pas gérés par l'application et qui ne sont pas affichés dans le DOM
    Page Should Contain Element    ${CHAMP_NOM_REVENU}
    Page Should Contain Element    ${H1_AJOUTER_REVENU}
   