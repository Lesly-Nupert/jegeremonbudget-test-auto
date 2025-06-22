*** Settings ***
Library          SeleniumLibrary
Resource         ../resources/commun.resource
Resource         ../resources/compte_bancaire.resource
Resource         ../resources/connexion.resource
Test Setup       Ouvrir Le Navigateur Et Accéder À L'Application
Test Teardown    Fermer Le Navigateur

*** Variables ***
${EMAIL_VALIDE}                                      test100@test.com
${MDP_VALIDE}                                        Testtest7+
${NOM_COMPTE_BANCAIRE_VALIDE}                        Compte Test
${NOM_COMPTE_BANCAIRE_INVALIDE_VIDE}                 ${EMPTY}
${NOM_COMPTE_BANCAIRE_INVALIDE_CARACTERE_SPECIAL}    Compte Test*
${NOM_COMPTE_BANCAIRE_INVALIDE_CHIFFRE}              Compte 1
${NOM_COMPTE_BANCAIRE_INVALIDE_ESPACE_DEBUT}         ${SPACE}Compte Test
${NOM_COMPTE_BANCAIRE_INVALIDE_ESPACE_FIN}           Compte Test${SPACE}

*** Test Cases ***
Test Création D'Un Compte Bancaire Valide Via Le Burger
    [Documentation]    Créer un premier compte bancaire valide
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_VALIDE}
    Valider La Création D'Un Compte Bancaire
    Vérifier Création D'un Compte Bancaire Réussie

Test Création D'Un Compte Bancaire Invalide Vide
    [Documentation]    Créer un compte bancaire invalide (vide)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_INVALIDE_VIDE}
    Valider La Création D'Un Compte Bancaire
    Vérifier Formulaire Compte Bancaire Non Soumis

Test Création D'Un Compte Bancaire Invalide Caractère Spécial
    [Documentation]    Créer un compte bancaire invalide (caractère spécial)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_INVALIDE_CARACTERE_SPECIAL}
    Valider La Création D'Un Compte Bancaire
    Vérifier Message D'erreur Pour Un Compte Bancaire Invalide

Test Création D'Un Compte Bancaire Invalide Nombre
    [Documentation]    Créer un compte bancaire invalide (nombre)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_INVALIDE_CHIFFRE}
    Valider La Création D'Un Compte Bancaire
    Vérifier Message D'erreur Pour Un Compte Bancaire Invalide

Test Création D'Un Compte Bancaire Invalide Espace Début
    [Documentation]    Créer un compte bancaire invalide (espace au début)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_INVALIDE_ESPACE_DEBUT}
    Valider La Création D'Un Compte Bancaire
    Vérifier Message D'erreur Pour Un Compte Bancaire Invalide

Test Création D'Un Compte Bancaire Invalide Espace Fin
    [Documentation]    Créer un compte bancaire invalide (espace à la fin)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_INVALIDE_ESPACE_FIN}
    Valider La Création D'Un Compte Bancaire
    Vérifier Message D'erreur Pour Un Compte Bancaire Invalide