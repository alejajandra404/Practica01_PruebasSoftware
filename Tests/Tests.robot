*** Settings ***
Library         SeleniumLibrary
Resource        ../Data/Variables.robot
Resource        ../Resources/Keywords.robot

*** Test Cases ***
S01_Login_Valido
    Inicializar Navegador
    Login       ${usuario_valido}           ${psw_valida}
    Page Should Contain    Products
    Close Browser

S02_Login_Invalido
    Inicializar Navegador
    Login       ${usuario_invalido}           ${psw_invalida}
    Page Should Not Contain    Products
    Close Browser

S03_ Autorizacion
    Open Browser                ${None}      ${browser}
    Go To                       ${URL_Inventory}
    Page Should Not Contain     Products
    Close Browser

S04_Usuario_Con_Error
    Inicializar Navegador
    Login                           ${usuario_error}    ${psw_valida}
    Click Element                   xpath=//*[@id="header_container"]/div[2]/div/span/select
    Click Element                   xpath=//*[@id="header_container"]/div[2]/div/span/select/option[2]
    Handle Alert
    Close Browser

S05_Agregar_Producto_Al_Carrito
    Inicializar Navegador
    Login                           ${usuario_valido}           ${psw_valida}
    Agregar Producto Al Carrito
    Page Should Contain             Sauce Labs Backpack
    Close Browser

S06_Verificar_Contador_Del_Carrito
    Inicializar Navegador
    Login                       ${usuario_valido}           ${psw_valida}
    Click Button                xpath=//button[@data-test='add-to-cart-sauce-labs-backpack']
    Sleep                       1s
    ${badge}=                   Get Text    class=shopping_cart_badge
    Should Be Equal             ${badge}    1
    Close Browser

S07_Ordenar_Productos_Por_Precio
    Inicializar Navegador
    Login                       ${usuario_valido}           ${psw_valida}
    Ordenar Productos Por Precio
    ${primer_precio}=           Get Text    xpath=(//div[@class='inventory_item_price'])[1]
    ${segundo_precio}=          Get Text    xpath=(//div[@class='inventory_item_price'])[2]
    Should Be True              '${primer_precio}' < '${segundo_precio}'
    Close Browser

S08_Verificar_Catalogo_6_Productos
    Inicializar Navegador
    Login                       ${usuario_valido}           ${psw_valida}
    ${productos}=               Get Element Count    class=inventory_item
    Should Be Equal As Numbers  ${productos}    6
    Close Browser

S09_Verificar_Titulo_Pagina_Productos
    Inicializar Navegador
    Login                       ${usuario_valido}           ${psw_valida}
    ${titulo}=                  Get Text    class=title
    Should Be Equal             ${titulo}    Products
    Close Browser

S10_Login_Usuario_Bloqueado
    Inicializar Navegador
    Login                       ${usuario_bloqueado}        ${psw_valida}
    Page Should Contain         Sorry, this user has been locked out.
    Close Browser