*** Settings ***
Library          SeleniumLibrary
Resource         ../resources/commun.resource
Resource         ../resources/connexion.resource
Test Setup       Ouvrir Le Navigateur Et Accéder À L'Application
Test Teardown    Fermer Le Navigateur
Test Template    Template Test Connexion

*** Variables ***
# ✅ Données de test factices sinon il aurait fallu les mettre dans le .env pour plus de sécurité
${EMAIL_VALIDE}                           test100@test.com
${EMAIL_INVALIDE}                         test100@test
${EMAIL_INVALIDE_SANS_AROBASE}            test.com
${EMAIL_INVALIDE_CARACTERE_SPECIAL}       test*@test.com
${MDP_VALIDE}                             Testtest7+
${MDP_INVALIDE_7_CARACTERES}              Test12+
${MDP_INVALIDE_13_CARACTERES}             Test12345678+
${MDP_INVALIDE_SANS_MAJUSCULE}            test1234+
${MDP_INVALIDE_SANS_CHIFFRE}              Testmdp+
${MDP_INVALIDE_SANS_CARACTERE_SPECIAL}    Test1234


*** Test Cases ***                                          EMAIL                 MDP                             RESULTAT
# ✅ Traçabilité des tests avec les résultats attendus (Exemple : Connexion Données Valides va avec SUCCES)
Connexion Données Valides                                   ${EMAIL_VALIDE}      ${MDP_VALIDE}                    SUCCES
    [Tags]    critical
Connexion Email Vide                                        ${EMPTY}             ${MDP_VALIDE}                    ERREUR_EMAIL_VIDE
    [Tags]    medium
Connexion Email Invalide                                    ${EMAIL_INVALIDE}    ${MDP_VALIDE}                    ERREUR_EMAIL_INVALIDE
    [Tags]    high
Connexion Email Vide                                        ${EMPTY}             ${MDP_VALIDE}                    ERREUR_EMAIL_VIDE
    [Tags]    medium
Connexion Email Invalide                                    ${EMAIL_INVALIDE}    ${MDP_VALIDE}                    ERREUR_EMAIL_INVALIDE
    [Tags]    high
Connexion Email Invalide Sans Arobase                       ${EMAIL_INVALIDE_SANS_AROBASE}    ${MDP_VALIDE}       ERREUR_EMAIL_INVALIDE_SANS_AROBASE
    [Tags]    high
Connexion Email Invalide Caractère Spécial                  ${EMAIL_INVALIDE_CARACTERE_SPECIAL}    ${MDP_VALIDE}  ERREUR_EMAIL_CARACTERE_SPECIAL
    [Tags]    high
Connexion Mot De Passe Vide                                 ${EMAIL_VALIDE}     ${EMPTY}                          ERREUR_MDP_VIDE
    [Tags]    medium
Connexion Mot De Passe Invalide 7 Caractères                ${EMAIL_VALIDE}     ${MDP_INVALIDE_7_CARACTERES}      ERREUR_MDP_7_CARACTERES
    [Tags]    high
Connexion Mot De Passe Invalide 13 Caractères               ${EMAIL_VALIDE}     ${MDP_INVALIDE_13_CARACTERES}     ERREUR_MDP_13_CARACTERES
    [Tags]    high
Connexion Mot De Passe Invalide Sans Majuscule              ${EMAIL_VALIDE}     ${MDP_INVALIDE_SANS_MAJUSCULE}    ERREUR_MDP_SANS_MAJUSCULE
    [Tags]    high
Connexion Mot De Passe Invalide Sans Chiffre                ${EMAIL_VALIDE}     ${MDP_INVALIDE_SANS_CHIFFRE}      ERREUR_MDP_SANS_CHIFFRE
    [Tags]    high
Connexion Mot De Passe Invalide Sans Caractère Spécial      ${EMAIL_VALIDE}     ${MDP_INVALIDE_SANS_CARACTERE_SPECIAL}  ERREUR_MDP_SANS_CARACTERE_SPECIAL
    [Tags]    high

*** Keywords ***
Template Test Connexion
    [Arguments]    ${email}    ${mdp}    ${resultat_attendu}
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${email}    ${mdp}
    Valider Le Formulaire De Connexion
    Traiter Le Résultat    ${resultat_attendu}

Traiter Le Résultat
    [Arguments]    ${resultat}
    # ✅ Dispatcher qui exécute la bonne vérification selon le résultat attendu
    # ✅ Messages d'erreur applicatifs VS validations HTML natives traitées avec le mot clé : Vérifier Formulaire Connexion Non Soumis
    Run Keyword If    '${resultat}' == 'SUCCES'                              Vérifier Connexion Réussie
    ...    ELSE IF    '${resultat}' == 'ERREUR_EMAIL_VIDE'                   Vérifier Formulaire Connexion Non Soumis 
    ...    ELSE IF    '${resultat}' == 'ERREUR_EMAIL_INVALIDE'               Vérifier Message D'Erreur Connexion    ${MSG_EMAIL_INVALIDE_CONNEXION}  
    ...    ELSE IF    '${resultat}' == 'ERREUR_EMAIL_INVALIDE_SANS_AROBASE'  Vérifier Formulaire Connexion Non Soumis    
    ...    ELSE IF    '${resultat}' == 'ERREUR_EMAIL_CARACTERE_SPECIAL'      Vérifier Message D'Erreur Connexion    ${MSG_EMAIL_INVALIDE_CONNEXION}
    ...    ELSE IF    '${resultat}' == 'ERREUR_MDP_VIDE'                     Vérifier Formulaire Connexion Non Soumis
    ...    ELSE IF    '${resultat}' == 'ERREUR_MDP_7_CARACTERES'             Vérifier Message D'Erreur Connexion    ${MSG_MDP_INVALIDE_CONNEXION}
    ...    ELSE IF    '${resultat}' == 'ERREUR_MDP_13_CARACTERES'            Vérifier Message D'Erreur Connexion    ${MSG_MDP_INVALIDE_CONNEXION}
    ...    ELSE IF    '${resultat}' == 'ERREUR_MDP_SANS_MAJUSCULE'           Vérifier Message D'Erreur Connexion    ${MSG_MDP_INVALIDE_CONNEXION}
    ...    ELSE IF    '${resultat}' == 'ERREUR_MDP_SANS_CHIFFRE'             Vérifier Message D'Erreur Connexion    ${MSG_MDP_INVALIDE_CONNEXION}
    ...    ELSE IF    '${resultat}' == 'ERREUR_MDP_SANS_CARACTERE_SPECIAL'   Vérifier Message D'Erreur Connexion    ${MSG_MDP_INVALIDE_CONNEXION}        
    ...    ELSE    Fail    Résultat inattendu : ${resultat}   # ✅ Détecte les erreurs de frappe et évite les faux positifs exemple : 'SUCCCESS' au lieu de 'SUCCES'


    