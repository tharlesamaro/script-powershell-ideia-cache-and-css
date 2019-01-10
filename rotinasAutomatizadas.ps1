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

$action = "-1"

DO {

    $action = Read-Host -Prompt "Digite: (1) Limpar cache | (2) CSS CityBus | (3) CSS Financeiro | (4) CSS Geope | (0) Sair"

    $server = "\\SRVIDEIA\Dados\allCSS\"

    $pathDestinyCSSResource = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\Resource"
    $pathDestinyCSSResourceClasses = $pathDestinyCSSCityBusResource + "\classes.css"

    $pathDestinyCSSPortalLight = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\Skins\PortalLight"
    $pathDestinyCSSPortalLightClasses = $pathDestinyCSSCityBusPortalLight + "\classes.css"

    $pathDestinyCSSHTMLGrid = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\Skins\PortalLight\HTMLGrid"
    $pathdestinyCSSHTMLGridFile = $pathDestinyCSSHTMLGrid + "\grid.css"

    if ( $action -eq "1" ) {

        $pathSaved = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\config\saved\*"
        $pathCatalina = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\work\Catalina"
        $pathCache = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\cache\*"
        $pathWebrunstudio = "C:\Program Files (x86)\Softwell Solutions\Maker Studio\Webrun Studio\tomcat\webapps\webrunstudio\cacheCompressed\webrunstudio\*"

        $getChildPathSaved = Get-ChildItem $pathSaved | Measure-Object
        $getChildPathCache = Get-ChildItem $pathCache | Measure-Object
        $getChildPathWebrunstudio = Get-ChildItem $pathWebrunstudio | Measure-Object


        if ( $getChildPathSaved.count -ge 1 ) {
            Remove-Item -path $pathSaved -recurse
        }

        if ( Test-Path -Path $pathCache ) {
            Remove-Item -path $pathCatalina -recurse
        }

        if ( $getChildPathCache.count -ge 1 ) {
            Remove-Item -path $pathCache -recurse
        }

        if ( $getChildPathWebrunstudio.count -ge 1 ) {
            Remove-Item -path $pathWebrunstudio -recurse
        }
    }

    if ( $action -eq "2" ) {
    
        $pathOriginCSSCityBusResourceClasses = $server + "citybus\resource\classes.css"
        $pathOriginCSSCityBusPortalLightClasses = $server + "citybus\classes.css"
        $pathOriginCSSCityBusGrid = $server + "citybus\grid.css"

        if ( Test-Path -Path $pathOriginCSSCityBusResourceClasses ) {

            if ( Test-Path -Path $pathDestinyCSSResourceClasses ) {
                Remove-Item -path $pathDestinyCSSResourceClasses -recurse
            }

            Copy-Item $pathOriginCSSCityBusResourceClasses -Destination $pathDestinyCSSResource
        }

        if ( Test-Path -Path $pathOriginCSSCityBusPortalLightClasses ) {
        
            if ( Test-Path -Path $pathDestinyCSSPortalLightClasses ) {
                Remove-Item -path $pathDestinyCSSPortalLightClasses -recurse
            }

            Copy-Item $pathOriginCSSCityBusPortalLightClasses -Destination $pathDestinyCSSPortalLight
        }

        if ( Test-Path -Path $pathOriginCSSCityBusGrid ) {

            if ( Test-Path -Path $pathdestinyCSSHTMLGridFile ) {
                Remove-Item -path $pathdestinyCSSHTMLGridFile -recurse
            }

            Copy-Item $pathOriginCSSCityBusGrid -Destination $pathDestinyCSSHTMLGrid  
        }
    }

    if ( $action -eq "3" ) {
    
        $pathOriginCSSFinanceiroResourceClasses = $server + "financeiro\resource\classes.css"
        $pathOriginCSSFinanceiroPortalLightClasses = $server + "financeiro\classes.css"
        $pathOriginCSSFinanceiroGrid = $server + "financeiro\grid.css"

        if ( Test-Path -Path $pathOriginCSSFinanceiroResourceClasses ) {

            if ( Test-Path -Path $pathDestinyCSSResourceClasses ) {
                Remove-Item -path $pathDestinyCSSResourceClasses -recurse
            }

            Copy-Item $pathOriginCSSFinanceiroResourceClasses -Destination $pathDestinyCSSResource
        }

        if ( Test-Path -Path $pathOriginCSSFinanceiroPortalLightClasses ) {
        
            if ( Test-Path -Path $pathDestinyCSSPortalLightClasses ) {
                Remove-Item -path $pathDestinyCSSPortalLightClasses -recurse
            }

            Copy-Item $pathOriginCSSFinanceiroPortalLightClasses -Destination $pathDestinyCSSPortalLight
        }

        if ( Test-Path -Path $pathOriginCSSFinanceiroGrid ) {

            if ( Test-Path -Path $pathdestinyCSSHTMLGridFile ) {
                Remove-Item -path $pathdestinyCSSHTMLGridFile -recurse
            }

            Copy-Item $pathOriginCSSFinanceiroGrid -Destination $pathDestinyCSSHTMLGrid  
        }
    }

    if ( $action -eq "4" ) {

        $pathOriginCSSGeopeResourceClasses = $server + "geope\resource\classes.css"
        $pathOriginCSSGeopePortalLightClasses = $server + "geope\classes.css"
        $pathOriginCSSGeopeGrid = $server + "geope\grid.css"

        if ( Test-Path -Path $pathOriginCSSGeopeResourceClasses ) {

            if ( Test-Path -Path $pathDestinyCSSResourceClasses ) {
                Remove-Item -path $pathDestinyCSSResourceClasses -recurse
            }

            Copy-Item $pathOriginCSSGeopeResourceClasses -Destination $pathDestinyCSSResource
        }

        if ( Test-Path -Path $pathOriginCSSGeopePortalLightClasses ) {
        
            if ( Test-Path -Path $pathDestinyCSSPortalLightClasses ) {
                Remove-Item -path $pathDestinyCSSPortalLightClasses -recurse
            }

            Copy-Item $pathOriginCSSGeopePortalLightClasses -Destination $pathDestinyCSSPortalLight
        }

        if ( Test-Path -Path $pathOriginCSSGeopeGrid ) {

            if ( Test-Path -Path $pathdestinyCSSHTMLGridFile ) {
                Remove-Item -path $pathdestinyCSSHTMLGridFile -recurse
            }

            Copy-Item $pathOriginCSSGeopeGrid -Destination $pathDestinyCSSHTMLGrid  
        } 
    }

    Write-Host ""
    Write-Host "***********************************"
    Write-Host "*                                 *"
    Write-Host "* Operação realizada com sucesso! *"
    Write-Host "*                                 *"
    Write-Host "***********************************"
    Write-Host ""

} While ( $action -ne "0" )
