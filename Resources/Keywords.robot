*** Settings ***
Library         SeleniumLibrary
Resource        ../Data/Variables.robot

*** Keywords ***
Inicializar Navegador
    Open Browser    ${None}      ${browser}
    Go To           ${URL}

Login
    [Arguments]       ${username}       ${password}
    Input Text        id=user-name      ${username}
    Input Password    name=password     ${password}
    Click Button      id=login-button

Agregar Producto Al Carrito
    Click Button      xpath=//button[@data-test='add-to-cart-sauce-labs-backpack']
    Sleep             1s
    Click Element     class=shopping_cart_link
    Sleep             3s

Ordenar Productos Por Precio
    Select From List By Value    class=product_sort_container    lohi
    Sleep             2s