#Isso faz com que o script atual seja passado para um novo processo PowerShell no modo Administrador (se o usuário atual tiver acesso ao modo Administrador e o script não for iniciado como Administrador).
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

Write-Host ""
Write-Host "**************************************************************************************"
Write-Host "* .___    .___     .__           _________               __                          *"
Write-Host "* |   | __| _/____ |__|____     /   _____/__.__. _______/  |_  ____   _____   ______ *"
Write-Host "* |   |/ __ |/ __ \|  \__  \    \_____  <   |  |/  ___/\   __\/ __ \ /     \ /  ___/ *"
Write-Host "* |   / /_/ \  ___/|  |/ __ \_  /        \___  |\___ \  |  | \  ___/|  Y Y  \\___ \  *"
Write-Host "* |___\____ |\___  >__(____  / /_______  / ____/____  > |__|  \___  >__|_|  /____  > *"
Write-Host "*          \/    \/        \/          \/\/         \/            \/      \/     \/  *"
Write-Host "*                                                                                    *"
Write-Host "**************************************************************************************"
Write-Host ""

$server = "\\SRVIDEIA\Dados\allCSS\"

$pathDestinyCSSResource = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\Resource"
$pathDestinyCSSResourceClasses = $pathDestinyCSSCityBusResource + "\classes.css"

$pathDestinyCSSPortalLight = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\Skins\PortalLight"
$pathDestinyCSSPortalLightClasses = $pathDestinyCSSCityBusPortalLight + "\classes.css"

$pathDestinyCSSHTMLGrid = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\Skins\PortalLight\HTMLGrid"
$pathdestinyCSSHTMLGridFile = $pathDestinyCSSHTMLGrid + "\grid.css"

$action = "-1"

function delete-file-or-directory-if-exists
{
    Param ([string]$fileOrDirectory)

    if ( Test-Path -Path $fileOrDirectory ) {
        Remove-Item -path $fileOrDirectory -recurse
    }
}

function clean-directory
{
    Param ([String]$directory)

    $getChildOfDirectory = Get-ChildItem $directory | Measure-Object

    if ( $getChildOfDirectory.count -ge 1 ) {
        Remove-Item -path $directory -recurse
    }
}

function copy-file-to-directory
{
    Param([String]$newFile, [String]$destinationDirectory, [String]$oldFile)

    if ( Test-Path -Path $newFile ) {

        delete-file-or-directory-if-exists -fileOrDirectory $oldFile

        Copy-Item $newFile -Destination $destinationDirectory
    }
}

function show-message-success
{
    Write-Host ""
    Write-Host "***********************************"
    Write-Host "*                                 *"
    Write-Host "* Operação realizada com sucesso! *"
    Write-Host "*                                 *"
    Write-Host "***********************************"
    Write-Host ""
}

function show-message-error
{
    Write-Host ""
    Write-Host "***********************************"
    Write-Host "*                                 *"
    Write-Host "*     Operação não realizada!     *"
    Write-Host "*                                 *"
    Write-Host "***********************************"
    Write-Host ""
}

function service-on
{
    Param([String]$serviceName)

    $arrService = Get-Service -Name $serviceName

    if ( $arrService.Status -eq 'Running' ) {
        Write-Host ""
        Write-Host "***********************************"
        Write-Host "*                                 *"
        Write-Host "*     Serviço já está ativo!      *"
        Write-Host "*                                 *"
        Write-Host "***********************************"
        Write-Host ""
    }

    while ($arrService.Status -ne 'Running')
    {
        Start-Service $serviceName

        write-host $arrService.status
        write-host 'Iniciando Serviço...'

        $arrService.Refresh()

        if ( $arrService.Status -eq 'Running' ) {

            write-host $arrService.status

            show-message-success
        }
    }
}

function service-off
{
    Param([String]$serviceName)

    $arrService = Get-Service -Name $ServiceName

    if ( $arrService.Status -eq 'Stopped' ) {
        Write-Host ""
        Write-Host "***********************************"
        Write-Host "*                                 *"
        Write-Host "*     Serviço já está parado!     *"
        Write-Host "*                                 *"
        Write-Host "***********************************"
        Write-Host ""
    }

    while ($arrService.Status -ne 'Stopped')
    {
        write-host $arrService.status

        Stop-Service $ServiceName

        write-host 'Finalizando Serviço...'

        $arrService.Refresh()

        if ( $arrService.Status -eq 'Stopped' ) {

            write-host $arrService.status

            show-message-success
        }
    }
}

DO {
    $action = Read-Host -Prompt "Digite: (1) Parar WebRun | (2) Iniciar WebRun | (3) Clear cache | (4) CSS CityBus | (5) CSS Financeiro | (6) CSS Geope | (0) Sair"

    if ( $action -eq "1" ) {
        try {
            service-off -serviceName "Webrun_Studio"
        }
        catch {
            show-message-error
        }
        
    }

    if ( $action -eq "2" ) {
        try {
            service-on -serviceName "Webrun_Studio"
        }
        catch{
            show-message-error
        }   
    }

    if ( $action -eq "3" ) {
        try{
            $pathSaved = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\config\saved\*"
            $pathCatalina = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\work\Catalina"
            $pathCache = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\cache\*"
            $pathWebrunstudio = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\cacheCompressed\webrunstudio\*"

            delete-file-or-directory-if-exists -fileOrDirectory $pathCatalina

            clean-directory -directory $pathSaved
            clean-directory -directory $pathCache
            clean-directory -directory $pathWebrunstudio

            show-message-success
        }
        catch{
            show-message-error
        }
    }

    if ( $action -eq "4" ) {
         try{
            $pathOriginCSSCityBusResourceClasses = $server + "citybus\resource\classes.css"
            $pathOriginCSSCityBusPortalLightClasses = $server + "citybus\classes.css"
            $pathOriginCSSCityBusGrid = $server + "citybus\grid.css"

            copy-file-to-directory -newFile $pathOriginCSSCityBusResourceClasses -destinationDirectory $pathDestinyCSSResource -oldFile $pathDestinyCSSResourceClasses
            copy-file-to-directory -newFile $pathOriginCSSCityBusPortalLightClasses -destinationDirectory $pathDestinyCSSPortalLight -oldFile $pathDestinyCSSPortalLightClasses
            copy-file-to-directory -newFile $pathOriginCSSCityBusGrid -destinationDirectory $pathDestinyCSSHTMLGrid -oldFile $pathdestinyCSSHTMLGridFile

            show-message-success
        }
        catch{
            show-message-error
        }
    }

    if ( $action -eq "5" ) {
        try{
            $pathOriginCSSFinanceiroResourceClasses = $server + "financeiro\resource\classes.css"
            $pathOriginCSSFinanceiroPortalLightClasses = $server + "financeiro\classes.css"
            $pathOriginCSSFinanceiroGrid = $server + "financeiro\grid.css"

            copy-file-to-directory -newFile $pathOriginCSSFinanceiroResourceClasses -destinationDirectory $pathDestinyCSSResource -oldFile $pathDestinyCSSResourceClasses
            copy-file-to-directory -newFile $pathOriginCSSFinanceiroPortalLightClasses -destinationDirectory $pathDestinyCSSPortalLight -oldFile $pathDestinyCSSPortalLightClasses
            copy-file-to-directory -newFile $pathOriginCSSFinanceiroGrid -destinationDirectory $pathDestinyCSSHTMLGrid -oldFile $pathdestinyCSSHTMLGridFile

            show-message-success
        }
        catch{
            show-message-error
        }
    }

    if ( $action -eq "6" ) {
        try{
            $pathOriginCSSGeopeResourceClasses = $server + "geope\resource\classes.css"
            $pathOriginCSSGeopePortalLightClasses = $server + "geope\classes.css"
            $pathOriginCSSGeopeGrid = $server + "geope\grid.css"

            copy-file-to-directory -newFile $pathOriginCSSGeopeResourceClasses -destinationDirectory $pathDestinyCSSResource -oldFile $pathDestinyCSSResourceClasses
            copy-file-to-directory -newFile $pathOriginCSSGeopePortalLightClasses -destinationDirectory $pathDestinyCSSPortalLight -oldFile $pathDestinyCSSPortalLightClasses
            copy-file-to-directory -newFile $pathOriginCSSGeopeGrid -destinationDirectory $pathDestinyCSSHTMLGrid -oldFile $pathdestinyCSSHTMLGridFile

            show-message-success
        }
        catch{
            show-message-error
        }
    }

} While ( $action -ne "0" )
