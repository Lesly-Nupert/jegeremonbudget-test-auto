*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/commun.resource
Resource   ../resources/inscription.resource
Resource   ../resources/connexion.resource
Resource   ../resources/compte_bancaire.resource
Resource   ../resources/revenu.resource
Resource   ../resources/depense.resource
Test Setup    Ouvrir Le Navigateur Et Accéder À L'Application
Test Teardown    Fermer Le Navigateur

*** Variables ***
# Données de test - Inscription et Connexion
${NOM_VALIDE}            test
${EMAIL_VALIDE}          test@test.com  # ⚠️Utilise un email unique généré par le mot-clé "Générer Email Unique" disponible dans tout le test - Ici dans l'étape d'inscription et de connexion
${MDP_VALIDE}            Test1234+

# Données de test - Création d'un nouveau compte bancaire
${NOM_COMPTE_BANCAIRE_VALIDE}    Compte Test

# Données de test -  Solde du compte bancaire avant création d'un revenu
${SOLDE_COMPTE_BANCAIRE_AVANT_CREATION_REVENU_A_ZERO}    0

# Données de test - Création d'un revenu
${NOM_REVENU_VALIDE}    Salaire
${MONTANT_REVENU_VALIDE}    100.00

# Données de test - Solde du compte bancaire après création d'un revenu
${SOLDE_COMPTE_BANCAIRE_APRES_CREATION_REVENU}    100.00

# Données de test - Création d'une dépense
${NOM_DEPENSE_VALIDE}    Loyer
${MONTANT_DEPENSE_VALIDE}    60.00

# Données de test - Solde du compte bancaire après création d'une dépense
${SOLDE_COMPTE_BANCAIRE_APRES_CREATION_DEPENSE}    40


*** Test Cases ***
Test Parcours Utilisateur : Inscription, Connexion, Création Compte Bancaire, Création Revenu, Création Dépense
    [Documentation]    Ce test couvre le parcours utilisateur : Inscription, Connexion, Création d'un compte bancaire, Création d'un revenu et Création d'une dépense et vérifie les soldes du compte bancaire à chaque étape.

    # Étape 1 : Inscription
    ${email_unique}    Générer Email Unique
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${email_unique}    ${MDP_VALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Inscription Réussie

    # Étape 2 : Connexion
    Remplir Le Formulaire De Connexion    ${email_unique}    ${MDP_VALIDE}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie

    # Étape 3 : Création d'un nouveau compte bancaire via le Burger
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Premier Compte Uniquement
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_VALIDE}
    Valider La Création D'Un Compte Bancaire
    Vérifier Création D'un Compte Bancaire Réussie

    # Étape 4 : Vérification du solde du compte bancaire avant création d'un revenu - ⚠️ Ce mot clé est dans commun.resource
    Vérifier Solde Du Compte    ${SOLDE_COMPTE_BANCAIRE_AVANT_CREATION_REVENU_A_ZERO}

    # Étape 5 : Création d'un revenu
    Aller Sur Le Formulaire D'ajout D'un Revenu
    Remplir Le Formulaire De Création D'Un Revenu   ${NOM_REVENU_VALIDE}    ${MONTANT_REVENU_VALIDE}
    Valider La Création D'Un Revenu
    Vérifier Création D'un Revenu Réussie

    # Étape 6 : Vérification du solde du compte bancaire après création d'un revenu - ⚠️ Ce mot clé est dans commun.resource
    Vérifier Solde Du Compte    ${SOLDE_COMPTE_BANCAIRE_APRES_CREATION_REVENU}

    # Étape 7 : Création d'une dépense
    Aller Sur Le Formulaire D'ajout D'une Dépense
    Remplir Le Formulaire De Création D'Une Dépense   ${NOM_DEPENSE_VALIDE}    ${MONTANT_DEPENSE_VALIDE}
    Valider La Création D'Une Dépense
    Vérifier Création D'une Dépense Réussie

    # Étape 8 : Vérification du solde du compte bancaire après création d'une dépense - ⚠️ Ce mot clé est dans commun.resource
    Vérifier Solde Du Compte    ${SOLDE_COMPTE_BANCAIRE_APRES_CREATION_DEPENSE}





