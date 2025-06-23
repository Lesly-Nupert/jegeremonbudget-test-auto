*** Settings ***
Library    SeleniumLibrary
Resource   commun.resource

*** Variables ***
# Locators
${LIEN_CONNEXION}        css=a[aria-label='Accès au formulaire de connexion']  
${CHAMP_EMAIL_CONNEXION}    id=email
${CHAMP_MOT_DE_PASSE_CONNEXION}    id=password
${BOUTON_CONNEXION}      //button[normalize-space()='Se connecter']
${MESSAGE_ALERT}    //div[@role='alert']
${H1_CONNEXION}          //h1[normalize-space()='Connexion']

# Messages de l'application (succès ET erreurs)
# Le Mot Clé "Vérifier Formulaire Connexion Non Soumis" gère les messages d'erreur HTML natifs
${MSG_CONNEXION_REUSSIE}    Connexion réussie ! Redirection en cours...
${MSG_EMAIL_INVALIDE_CONNEXION}    ERREUR Format d'email attendu : exemple@exemple.com
${MSG_MDP_INVALIDE_CONNEXION}    ERREUR Votre mot de passe doit contenir entre 8 et 12 caractères, avec au moins une lettre majuscule, un chiffre et un caractère spécial.

*** Keywords ***
Aller Sur Le Formulaire De Connexion
    Click Element    ${LIEN_CONNEXION}
    Wait Until Element Is Visible    ${CHAMP_EMAIL_CONNEXION}    timeout=10s

Remplir Le Formulaire De Connexion
    [Arguments]    ${email}    ${motdepasse}
    Input Text     ${CHAMP_EMAIL_CONNEXION}         ${email}
    Click Element  ${CHAMP_MOT_DE_PASSE_CONNEXION}    
    Input Password     ${CHAMP_MOT_DE_PASSE_CONNEXION}  ${motdepasse}

Valider Le Formulaire De Connexion
    # ✅ "${status}    Run Keyword And Return Status" # Vérifie que le message d'alerte est affiché et récupère son statut mais sans faire échouer le test si le message n'est pas visible (Solution pour contourner les messages d'erreur HTML natifs non visibles dans le DOM)
    Wait Until Element Is Visible    ${BOUTON_CONNEXION}    timeout=10s
    Click Button    ${BOUTON_CONNEXION}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=5s

Vérifier Connexion Réussie
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_CONNEXION_REUSSIE}
    
Vérifier Message D'Erreur Connexion
    [Arguments]    ${message_attendu}
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${message_attendu}

Vérifier Formulaire Connexion Non Soumis
    [Documentation]    Contourne les messages d'erreur HTML natifs qui ne sont pas gérés par l'application et qui ne sont pas affichés dans le DOM
    Page Should Contain Element    ${H1_CONNEXION}
    Page Should Contain Element    ${CHAMP_EMAIL_CONNEXION}
    
