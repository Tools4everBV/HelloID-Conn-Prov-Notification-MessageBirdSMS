#####################################################
# HelloID-Conn-Prov-Notification-MessageBird
#
# Version: 1.1.0
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

        # Set authorizationheaders
        $headers = [System.Collections.Generic.Dictionary[string, string]]::new()
        $headers.Add("Authorization", "AccessKey $($actionContext.Configuration.accesskey)")

        $sendMessageBody = @{
            recipients = $actionContext.TemplateConfiguration.recipients
            originator = $actionContext.Configuration.originator
            body       = $actionContext.TemplateConfiguration.body
        }

        # Optional, define date and time of the message
        if (![String]::IsNullOrEmpty($actionContext.TemplateConfiguration.time)) {
            # Define the date and time
            $currentDate = Get-date
            $time = $actionContext.TemplateConfiguration.time

            # Create a DateTime object of current date and specified time
            $dateTimeString = $currentDate.toString("yyyy-MM-dd") + " $time"
            $scheduledDatetime = [datetime]$dateTimeString

            # Convert DateTime to RFC3339 format (Y-m-d\TH:i:sP)
            $scheduledDatetimeRFC = $scheduledDatetime.ToString("yyyy-MM-dd\THH:mm:sszzz", [System.Globalization.CultureInfo]::InvariantCulture)
            $sendMessageBody += @{ scheduledDatetime = $scheduledDatetimeRFC }
        }

        $body = $sendMessageBody | ConvertTo-Json
        $splatParams = @{
            Uri         = $actionContext.Configuration.baseUri
            Headers     = $headers
            Method      = 'POST'
            Body        = ([System.Text.Encoding]::UTF8.GetBytes($body))
            ContentType = "application/json"
            ErrorAction = "Stop"
        }

        if (-Not($actionContext.DryRun -eq $true)) {
            if ("scheduledDatetime" -in $sendMessageBody.Keys) {
                Write-Verbose "Scheduling MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)] at [$($sendMessageBody.scheduledDatetime)]"
            }
            else {
                Write-Verbose "Sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)]"
            }

            $response = Invoke-RestMethod @splatParams

            if ("scheduledDatetime" -in $sendMessageBody.Keys) {
                $outputContext.AuditLogs.Add([PSCustomObject]@{
                        Message = "Successfully scheduled MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)] at [$($sendMessageBody.scheduledDatetime)]"
                        IsError = $false
                    })
            }
            else {
                $outputContext.AuditLogs.Add([PSCustomObject]@{
                        Message = "Successfully sent MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)]"
                        IsError = $false
                    })
            }
        }
        else {
            # Log what would happen during enforcement
            if ("scheduledDatetime" -in $sendMessageBody.Keys) {
                Write-Warning "DryRun: Would schedule MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)] at [$($sendMessageBody.scheduledDatetime)]"
            }
            else {
                Write-Warning "DryRun: Would Send MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)]"
            }
            Write-Verbose "Uri: $($splatParams.Uri)"
            Write-Verbose "Body: $($sendMessageBody)"
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
    Write-Verbose "Body: $($sendMessageBody)"
    Write-Verbose "SplatParams: $($splatParams | ConvertTo-Json)"

    switch ($ex.Exception.Message) {       
        'Incorrect scriptFlow' {
            $errorMessage = "Incorrect scriptFlow [$($actionContext.TemplateConfiguration.scriptFlow)]"
        }
        default {
            if ($($ex.Exception.GetType().FullName -eq 'Microsoft.PowerShell.Commands.HttpResponseException') -or
                $($ex.Exception.GetType().FullName -eq 'System.Net.WebException')) {
                if ("scheduledDatetime" -in $sendMessageBody.Keys) {
                    
                    $errorMessage = "Error scheduling MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)] at [$($sendMessageBody.scheduledDatetime)]. Error: $($ex.ErrorDetails.Message)"
                }
                else {
                    $errorMessage = "Error sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)]. Error: $($ex.ErrorDetails.Message)"
                }
            }
            else {
                if ("scheduledDatetime" -in $sendMessageBody.Keys) {
                    $errorMessage = "Error scheduling MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)] at [$($sendMessageBody.scheduledDatetime)]. Error: $($ex.Exception.Message) $($ex.ScriptStackTrace)"
                }
                else {
                    $errorMessage = "Error sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] to [$($sendMessageBody.recipients)]. Error: $($ex.Exception.Message) $($ex.ScriptStackTrace)"
                }
            }
        }
    }

    $outputContext.AuditLogs.Add([PSCustomObject]@{
            Message = $errorMessage
            IsError = $true
        })
}
finally {
    # Check if auditLogs contains errors, if no errors are found, set success to true
    if (-NOT($outputContext.AuditLogs.isError -contains $true)) {
        $success = $true
    }

    $outputContext.Success = $success
}