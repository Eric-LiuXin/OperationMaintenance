#Install IIS
function InstallIIS{
    $Data = Dism /online /Get-FeatureInfo /FeatureName:IIS-WebServerRole
    if($Data -Contains ("State : Disabled")){
        #Enable Internet Information Services
        dism /Online /Enable-Feature /FeatureName:IIS-WebServerRole

        #Enable FTP Server
        dism /Online /Enable-Feature /FeatureName:IIS-FTPServer `
                                     /FeatureName:IIS-FTPSvc `
                                     /FeatureName:IIS-FTPExtensibility

        #Enable Web Management Tools
        dism /Online /Enable-Feature /FeatureName:IIS-WebServerManagementTools `
                                     /FeatureName:IIS-IIS6ManagementCompatibility `
                                     /FeatureName:IIS-ManagementConsole `
                                     /FeatureName:IIS-ManagementScriptingTools `
                                     /FeatureName:IIS-ManagementService `
                                     /FeatureName:IIS-Metabase `
                                     /FeatureName:IIS-LegacySnapIn

        #Enable World Wide Web Services
        dism /Online /Enable-Feature /FeatureName:IIS-WebServer `
                                     /FeatureName:IIS-ApplicationDevelopment `
                                     /FeatureName:IIS-CommonHttpFeatures `
                                     /FeatureName:IIS-HealthAndDiagnostics `
                                     /FeatureName:IIS-Performance `
                                     /FeatureName:IIS-Security 
    }
}
