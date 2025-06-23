*** Settings ***
Library    SeleniumLibrary
Resource   commun.resource

*** Variables ***
# Locators
${LIEN_INSCRIPTION}      //a[@aria-label="Accès au formulaire d'inscription"]
${CHAMP_NOM}             id=username
${CHAMP_EMAIL}           id=email
${CHAMP_MOT_DE_PASSE}    id=password
${CASE_CONDITIONS}       id=checkbox
${BOUTON_VALIDATION}     //button[normalize-space()='Valider mon inscription']
${MESSAGE_ALERT}         //div[@role='alert']
${H1_INSCRIPTION}        //h1[normalize-space()='Inscription']
${H1_CONNEXION}          //h1[normalize-space()='Connexion']

# Messages de l'application (succès ET erreurs)
# Le Mot Clé "Vérifier Formulaire Inscription Non Soumis" gère les messages d'erreur HTML natifs
${MSG_INSCRIPTION_REUSSIE}  Inscription réussie ! Redirection en cours...
${MSG_EMAIL_INVALIDE}       ERREUR Format d'email attendu : exemple@exemple.com
${MSG_EMAIL_EXISTE}         ERREUR Cet email existe déjà
${MSG_MDP_INVALIDE}         ERREUR Votre mot de passe doit contenir entre 8 et 12 caractères, avec au moins une lettre majuscule, un chiffre et un caractère spécial


*** Keywords ***
Générer Email Unique
    [Documentation]    ✅ Génère un email unique basé sur le timestamp actuel pour éviter les doublons lors des tests automatisés en CI/CD.
    ${timestamp}    Get Time    epoch
    # Construit l'email unique en concaténant le timestamp
    ${email_unique}    Set Variable    test.${timestamp}@test.com
    RETURN    ${email_unique}

Aller Sur Le Formulaire D'Inscription
    Click Element    ${LIEN_INSCRIPTION}
    Wait Until Element Is Visible    ${CHAMP_NOM}    timeout=10s

Remplir Le Formulaire D'Inscription
    [Arguments]    ${nom}    ${email}    ${motdepasse}    ${cocher_conditions}=True
    Input Text     ${CHAMP_NOM}           ${nom}
    Input Text     ${CHAMP_EMAIL}         ${email}
    Input Password     ${CHAMP_MOT_DE_PASSE}  ${motdepasse}
    Run Keyword If    ${cocher_conditions}    Click Element    ${CASE_CONDITIONS}

Valider Le Formulaire D'Inscription
    # ✅ "${status}    Run Keyword And Return Status" Vérifie que le message d'alerte est affiché et récupère son statut mais sans faire échouer le test si le message n'est pas visible (Solution pour contourner les messages d'erreur HTML natifs non visibles dans le DOM)
    Click Button    ${BOUTON_VALIDATION}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=20s

Vérifier Inscription Réussie
    Element Should Contain    ${MESSAGE_ALERT}    ${MSG_INSCRIPTION_REUSSIE}
    Wait Until Element Is Visible    ${H1_CONNEXION}    timeout=10s

Vérifier Message D'Erreur
    [Arguments]    ${message_attendu}
    Wait Until Element Is Visible    ${MESSAGE_ALERT}    timeout=10s
    Element Should Contain    ${MESSAGE_ALERT}    ${message_attendu}

Vérifier Formulaire Inscription Non Soumis
    [Documentation]    Contourne les messages d'erreur HTML natifs qui ne sont pas gérés par l'application et qui ne sont pas affichés dans le DOM
    Page Should Contain Element    ${CHAMP_NOM}
    Page Should Contain Element    ${H1_INSCRIPTION}