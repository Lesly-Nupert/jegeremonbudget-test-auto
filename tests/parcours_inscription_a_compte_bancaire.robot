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
# Données de test - Inscription
${NOM_VALIDE}            test
${EMAIL_VALIDE}          test@test.com  # Utilise un email unique généré par le mot-clé "Générer Email Unique"
${MDP_VALIDE}            Test1234+

# Données de test - Connexion (Compte existant)
${EMAIL_VALIDE_CONNEXION}    test100@test.com
${MDP_VALIDE_CONNEXION}    Testtest7+

# Données de test - Création d'un nouveau compte bancaire (CI/CD)
${NOM_COMPTE_BANCAIRE_VALIDE_CI_CD}    Compte Test CI CD

*** Test Cases ***
Test Parcours Utilisateur : Inscription, Connexion, Création Nouveau Compte bancaire
    # Étape 1 : Inscription
    ${email_unique}    Générer Email Unique
    Aller Sur Le Formulaire D'Inscription
    Remplir Le Formulaire D'Inscription    ${NOM_VALIDE}    ${email_unique}    ${MDP_VALIDE}    True
    Valider Le Formulaire D'Inscription
    Vérifier Inscription Réussie

    # Étape 2 : Connexion
    Remplir Le Formulaire De Connexion    ${EMAIL_VALIDE_CONNEXION}    ${MDP_VALIDE_CONNEXION}
    Valider Le Formulaire De Connexion
    Vérifier Connexion Réussie

    # Étape 3 : Création d'un nouveau compte bancaire via le Burger
    Aller Sur Le Formulaire D'ajout D'un Compte Bancaire Via Le Menu Burger
    Remplir Le Formulaire De Création D'Un Compte Bancaire    ${NOM_COMPTE_BANCAIRE_VALIDE_CI_CD}
    Valider La Création D'Un Compte Bancaire
    Vérifier Création D'un Compte Bancaire Réussie