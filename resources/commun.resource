*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                     https://jegeremonbudget.netlify.app
${BROWSER}                 chrome

*** Keywords ***
# Setup et Teardown
Ouvrir Le Navigateur Et Accéder À L'Application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    1s

Fermer Le Navigateur
    Close Browser

