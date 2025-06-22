*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/depense.resource
Resource   ../resources/connexion.resource
Test Setup    Ouvrir Le Navigateur Et Accéder À L'Application
Test Teardown    Fermer Le Navigateur

*** Variables ***
${EMAIL_VALIDE}    test100@test.com
${MDP_VALIDE}    Testtest7+
${NOM_DEPENSE_VALIDE}    Dépense valide
${NOM_DEPENSE_INVALIDE_VIDE}    ${EMPTY}
${NOM_DEPENSE_INVALIDE_CARACTERE_SPECIAL}    Dépense*
${NOM_DEPENSE_INVALIDE_CHIFFRE}    Dépense1
${NOM_DEPENSE_INVALIDE_ESPACE_DEBUT}    ${SPACE}Dépense
${NOM_DEPENSE_INVALIDE_ESPACE_FIN}    Dépense${SPACE}
${MONTANT_VALIDE}    100
${MONTANT_INVALIDE_VIDE}    ${EMPTY}
${MONTANT_INVALIDE_NEGATIF}    -100
${MONTANT_INVALIDE_ZERO}    0

*** Test Cases ***
Test Création D'Une Dépense Valide
    [Documentation]    Créer une dépense valide
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_VALIDE}    ${MONTANT_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Création D'une Dépense Réussie

Test Création D'Une Dépense Invalide Vide
    [Documentation]    Créer une dépense invalide (vide)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_INVALIDE_VIDE}    ${MONTANT_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Formulaire Ajout Dépense Non Soumis

Test Création D'Une Dépense Invalide Caractère Spécial
    [Documentation]    Créer une dépense invalide (caractère spécial)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_INVALIDE_CARACTERE_SPECIAL}    ${MONTANT_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Message D'erreur Nom Dépense Invalide

Test Création D'Une Dépense Invalide Nombre
    [Documentation]    Créer une dépense invalide (nombre)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_INVALIDE_CHIFFRE}    ${MONTANT_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Message D'erreur Nom Dépense Invalide

Test Création D'Une Dépense Invalide Espace Début
    [Documentation]    Créer une dépense invalide (espace début)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_INVALIDE_ESPACE_DEBUT}    ${MONTANT_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Message D'erreur Nom Dépense Invalide

Test Création D'Une Dépense Invalide Espace Fin
    [Documentation]    Créer une dépense invalide (espace fin)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_INVALIDE_ESPACE_FIN}    ${MONTANT_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Message D'erreur Nom Dépense Invalide

Test Création D'Une Dépense Invalide Montant Vide
    [Documentation]    Créer une dépense invalide (montant vide)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_VALIDE}    ${MONTANT_INVALIDE_VIDE}
    Valider La Création D'Une Dépense
    Vérifier Formulaire Ajout Dépense Non Soumis

Test Création D'Une Dépense Invalide Montant Négatif
    [Documentation]    Créer une dépense invalide (montant négatif)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_VALIDE}    ${MONTANT_INVALIDE_NEGATIF}
    Valider La Création D'Une Dépense
    Vérifier Formulaire Ajout Dépense Non Soumis

Test Création D'Une Dépense Invalide Montant Zéro
    [Documentation]    Créer une dépense invalide (montant zéro)
    Aller Sur Le Formulaire De Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie
    Aller Sur Le Formulaire D'ajout D'une Dépense Via Le Lien D'Un Compte Bancaire Existant
    Remplir Le Formulaire De Création D'Une Dépense    ${NOM_DEPENSE_VALIDE}    ${MONTANT_INVALIDE_ZERO}
    Valider La Création D'Une Dépense
    Vérifier Formulaire Ajout Dépense Non Soumis
