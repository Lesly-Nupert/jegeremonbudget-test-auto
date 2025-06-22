*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                     https://jegeremonbudget.netlify.app
${BROWSER}                 chrome

${BALANCE_COMPTE_BANCAIRE}    css=p[aria-label='Balance du compte'] span

*** Keywords ***
# Setup et Teardown
Ouvrir Le Navigateur Et Accéder À L'Application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    1s

Fermer Le Navigateur
    Close Browser

# "Vérifier Solde Du Compte" déplacé dans commun.resource car il était utilisé dans plusieurs ressources (revenu.resource et depense.resource)
Vérifier Solde Du Compte
    [Arguments]    ${solde_attendu}
    Wait Until Element Is Visible    ${BALANCE_COMPTE_BANCAIRE}    timeout=20s
    Wait Until Element Contains    ${BALANCE_COMPTE_BANCAIRE}    ${solde_attendu}

