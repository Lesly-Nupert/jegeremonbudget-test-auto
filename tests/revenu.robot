*** Settings ***
Library          SeleniumLibrary
Resource         ../resources/commun.resource
Resource         ../resources/revenu.resource
Resource         ../resources/connexion.resource
Test Setup       Ouvrir Le Navigateur Et Accéder À L'Application
Test Teardown    Fermer Le Navigateur

*** Variables ***
${EMAIL_VALIDE}                             test100@test.com
${MDP_VALIDE}                               Testtest7+
${NOM_REVENU_VALIDE}                        Revenu valide
${NOM_REVENU_INVALIDE_VIDE}                 ${EMPTY}
${NOM_REVENU_INVALIDE_CARACTERE_SPECIAL}    Revenu*
${NOM_REVENU_INVALIDE_CHIFFRE}              Revenu1
${NOM_REVENU_INVALIDE_ESPACE_DEBUT}         ${SPACE}Revenu
${NOM_REVENU_INVALIDE_ESPACE_FIN}           Revenu${SPACE}
${MONTANT_VALIDE}                           100
${MONTANT_INVALIDE_VIDE}                    ${EMPTY}
${MONTANT_INVALIDE_NEGATIF}                 -100
${MONTANT_INVALIDE_ZERO}                    0

*** Test Cases ***
# --- TESTS POSITIFS ---
Test Création D'Un Revenu Valide
    [Documentation]    Créer un revenu valide
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_VALIDE}    ${MONTANT_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Création D'un Revenu Réussie

# --- TESTS NÉGATIFS ---
Test Création D'Un Revenu Invalide Vide
    [Documentation]    Créer un revenu invalide (vide)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_INVALIDE_VIDE}    ${MONTANT_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Formulaire Ajout Revenu Non Soumis

Test Création D'Un Revenu Invalide Caractère Spécial
    [Documentation]    Créer un revenu invalide (caractère spécial)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_INVALIDE_CARACTERE_SPECIAL}    ${MONTANT_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Message D'erreur Nom Revenu Invalide

Test Création D'Un Revenu Invalide Nombre
    [Documentation]    Créer un revenu invalide (nombre)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_INVALIDE_CHIFFRE}    ${MONTANT_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Message D'erreur Nom Revenu Invalide

Test Création D'Un Revenu Invalide Espace Début
    [Documentation]    Créer un revenu invalide (espace au début)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_INVALIDE_ESPACE_DEBUT}    ${MONTANT_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Message D'erreur Nom Revenu Invalide

Test Création D'Un Revenu Invalide Espace Fin
    [Documentation]    Créer un revenu invalide (espace à la fin)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_INVALIDE_ESPACE_FIN}    ${MONTANT_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Message D'erreur Nom Revenu Invalide

Test Création D'Un Revenu Invalide Montant Vide
    [Documentation]    Créer un revenu invalide (montant vide)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_VALIDE}    ${MONTANT_INVALIDE_VIDE}
    Valider La Création D'Un Revenu
    Vérifier Formulaire Ajout Revenu Non Soumis

Test Création D'Un Revenu Invalide Montant Négatif
    [Documentation]    Créer un revenu invalide (montant négatif)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_VALIDE}    ${MONTANT_INVALIDE_NEGATIF}
    Valider La Création D'Un Revenu
    Vérifier Formulaire Ajout Revenu Non Soumis

Test Création D'Un Revenu Invalide Montant Zéro
    [Documentation]    Créer un revenu invalide (montant zéro)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'un Revenu Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Un Revenu    ${NOM_REVENU_VALIDE}    ${MONTANT_INVALIDE_ZERO}
    Valider La Création D'Un Revenu
    Vérifier Formulaire Ajout Revenu Non Soumis

