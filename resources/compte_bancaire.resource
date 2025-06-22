*** Settings ***
Library    SeleniumLibrary
Resource   commun.resource
Resource   ../resources/connexion.resource

*** Variables ***
# Locators 
${CHAMP_NOM_COMPTE_BANCAIRE}    id=account_name
${BOUTON_CREER_COMPTE_BANCAIRE}    //button[normalize-space()='Ajouter le compte']
${MESSAGE_ALERT}    //div[@role='alert']
${H1_AJOUTER_COMPTE_BANCAIRE}    //h1[normalize-space()='Ajouter un compte bancaire']
${MENU_BURGER}    //span[@class='navbar-toggler-icon']
${LIEN_AJOUTER_COMPTE_BANCAIRE}    //a[normalize-space()='Ajouter un compte']

# Messages de l'application (succès ET erreurs)
# Le Mot Clé "Vérifier Formulaire Compte Bancaire Non Soumis" gère les messages d'erreur HTML natifs 
${MSG_AJOUT_COMPTE_REUSSIE}    Ajout du compte bancaire réussi ! Redirection en cours...
${MSG_COMPTE_INVALIDE}    ERREUR Votre nom de compte bancaire ne doit contenir que des lettres et aucun espace avant ou après.

*** Keywords ***
Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Premier Compte Uniquement
    Wait Until Element Is Visible    ${CHAMP_NOM_COMPTE_BANCAIRE}    timeout=10s
    Element Should Contain    ${H1_AJOUTER_COMPTE_BANCAIRE}    Ajouter un compte bancaire

Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger    #2ème méthode pour accéder au formulaire d'ajout d'un compte bancaire
    Wait Until Element Is Visible    ${MENU_BURGER}    timeout=20s
    Click Element    ${MENU_BURGER}
    Wait Until Element Is Visible    ${LIEN_AJOUTER_COMPTE_BANCAIRE}    timeout=20s
    # TEST : Utilisation de JavaScript pour cliquer sur le lien
    Sleep    2s
    Execute JavaScript    arguments[0].click();    ELEMENT:${LIEN_AJOUTER_COMPTE_BANCAIRE}
    
Remplir Le Formulaire De Création D'Un Compte Bancaire   
    [Arguments]    ${nom_compte_bancaire}
    Wait Until Element Is Visible    ${CHAMP_NOM_COMPTE_BANCAIRE}    timeout=10s
    Input Text    ${CHAMP_NOM_COMPTE_BANCAIRE}    ${nom_compte_bancaire}

Valider La Création D'Un Compte Bancaire
# ✅ "${status}    Run Keyword And Return Status" 
# Vérifie que le message d'alerte est affiché et récupère son statut mais sans faire échouer le test si le message n'est pas visible (Solution pour contourner les messages d'erreur HTML natifs non visibles dans le DOM)
    Click Button    ${BOUTON_CREER_COMPTE_BANCAIRE}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=5s

Vérifier Création D'un Compte Bancaire Réussie
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_AJOUT_COMPTE_REUSSIE}

Vérifier Message D'erreur Pour Un Compte Bancaire Invalide
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_COMPTE_INVALIDE}

Vérifier Formulaire Compte Bancaire Non Soumis
    # ✅ Contourne les messages d'erreur HTML natifs qui ne sont pas gérés par l'application et qui ne sont pas affichés dans le DOM
    Page Should Contain Element    ${CHAMP_NOM_COMPTE_BANCAIRE}
    Page Should Contain Element    ${H1_AJOUTER_COMPTE_BANCAIRE}
    
   