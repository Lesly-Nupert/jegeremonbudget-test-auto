*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/commun.resource
Resource          ../resources/inscription.resource
Test Setup        Ouvrir Le Navigateur Et Accéder À L'Application
Test Teardown     Fermer Le Navigateur

*** Variables ***
# ✅ Données de test factices sinon il aurait fallu les mettre dans le .env pour plus de sécurité
${NOM_VALIDE}            test
${EMAIL_VALIDE}          test@test.com   # Utilise un email unique généré par le mot-clé "Générer Email Unique"
${EMAIL_INVALIDE}        test@test
${EMAIL_EXISTANT}        test100@test.com
${MDP_VALIDE}            Test1234+
${MDP_INVALIDE}          123

*** Test Cases ***
Test Inscription Avec Données Valides
    [Documentation]    Créer un compte utilisateur avec tous les champs valides
    # Execute le mot-clé "Générer Email Unique" et le stocke dans la variable ${email_unique}
    [Tags]    critical
    ${email_unique}=    Générer Email Unique
    ${email_unique}    Générer Email Unique
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${email_unique}    ${MDP_VALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Inscription Réussie

Test Inscription Email Format Invalide
    [Documentation]    Créer un compte utilisateur avec un Email dont le format est invalide
    [Tags]    high
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${EMAIL_INVALIDE}    ${MDP_VALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Message D'Erreur    ${MSG_EMAIL_INVALIDE}

Test Inscription Email Existant
    [Documentation]    Créer un compte utilisateur avec une adresse Email existante
    [Tags]    high
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${EMAIL_EXISTANT}    ${MDP_VALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Message D'Erreur    ${MSG_EMAIL_EXISTE}

Test Inscription Mot De Passe Invalide
    [Documentation]    Créer un compte utilisateur avec un mot de passe ayant moins de 8 caractères
    [Tags]    high
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${EMAIL_VALIDE}    ${MDP_INVALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Message D'Erreur    ${MSG_MDP_INVALIDE}

Test Inscription Sans Accepter Conditions
    [Documentation]    Créer un compte utilisateur sans cocher les conditions
    [Tags]    medium  
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${EMAIL_VALIDE}    ${MDP_VALIDE}    False
    Valider Le Formulaire D'Inscription
    Vérifier Formulaire Inscription Non Soumis

Test Inscription Nom Vide
    [Documentation]    Créer un compte utilisateur avec un nom vide
    [Tags]    medium   
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${EMPTY}    ${EMAIL_VALIDE}    ${MDP_VALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Formulaire Inscription Non Soumis