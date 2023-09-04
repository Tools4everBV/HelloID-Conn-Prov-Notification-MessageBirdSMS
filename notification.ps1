#####################################################
# HelloID-Conn-Prov-Notification-MessageBird
#
# Version: 1.0.0
#####################################################

# Initialize default values
$success = $false

# Enable TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# Set debug logging
switch ($($actionContext.Configuration.IsDebug)) {
    $true { $VerbosePreference = 'Continue' }
    $false { $VerbosePreference = 'SilentlyContinue' }
}

try {
    if ($($actionContext.TemplateConfiguration.scriptFlow) -eq "SMS") {
        # Execute script flow SMS
        Write-Verbose "Sending notification for: [$($personContext.Person.DisplayName)]"

        # Set authorizationheaders
        $headers = [System.Collections.Generic.Dictionary[string, string]]::new()
        $headers.Add("Authorization", "AccessKey $($actionContext.Configuration.accesskey)")

        $body = @{
            recipients = $actionContext.TemplateConfiguration.recipients
            originator = $actionContext.Configuration.originator
            body       = $actionContext.TemplateConfiguration.body
        } | ConvertTo-Json

        $splatParams = @{
            Uri         = $actionContext.Configuration.baseUri
            Headers     = $headers
            Method      = 'POST'
            Body        = ([System.Text.Encoding]::UTF8.GetBytes($body))
            ContentType = "application/json"
            ErrorAction = "Stop"
        }

        if (-Not($actionContext.DryRun -eq $true)) {
            $response = Invoke-RestMethod @splatParams

            $outputContext.AuditLogs.Add([PSCustomObject]@{
                    Message = "Successfully sent MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]"
                    IsError = $false
                })
        }
        else {
            # Log what would happen during enforcement
            Write-Warning "DryRun: Would Send notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]"
            Write-Verbose "Uri: $($splatParams.Uri)"
            Write-Verbose "Body: $($body)"
        }
    }
    else {
        throw "Incorrect scriptFlow"
    }
}
catch {
    $ex = $PSItem    
    Write-Verbose "Error: $($ex.Exception.Message)"
    Write-Verbose "Uri: $($splatParams.Uri)"
    Write-Verbose "Body: $($body)"
    Write-Verbose "SplatParams: $($splatParams | ConvertTo-Json)"

    switch ($ex.Exception.Message) {       
        'Incorrect scriptFlow' {
            $errorMessage = "Incorrect scriptFlow [$($actionContext.TemplateConfiguration.scriptFlow)]"
        }
        
        default {
            if ($($ex.Exception.GetType().FullName -eq 'Microsoft.PowerShell.Commands.HttpResponseException') -or
                $($ex.Exception.GetType().FullName -eq 'System.Net.WebException')) {
                $errorMessage = "Error sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]. Error: $($ex.ErrorDetails.Message)"
            }
            else {
                $errorMessage = "Error sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]. Error: $($ex.Exception.Message) $($ex.ScriptStackTrace)"
            } 
            $outputContext.AuditLogs.Add([PSCustomObject]@{
                    Message = $errorMessage
                    IsError = $true
                })
        }
    }
}
finally {
    # Check if auditLogs contains errors, if no errors are found, set success to true
    if (-NOT($outputContext.AuditLogs.isError -contains $true)) {
        $success = $true
    }

    $outputContext.Success = $success
}