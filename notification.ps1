# Initialize default values
$success = $false

# Enable TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# Set debug logging
switch ($($actionContext.Configuration.IsDebug)) {
    $true { $VerbosePreference = 'Continue' }
    $false { $VerbosePreference = 'SilentlyContinue' }
}

function Set-AuthorizationHeaders {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $AccessKey
    )
    
    # Set authentication headers
    $authHeaders = [System.Collections.Generic.Dictionary[string, string]]::new()    
    $authHeaders.Add("Content-Type", "application/json")
    Write-Output $authHeaders
}

function Invoke-MessageBirdRestMethod {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Method,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri,

        [object]
        $Body,

        [string]
        $ContentType = 'application/json',

        [Parameter(Mandatory)]
        [System.Collections.IDictionary]
        $Headers
    )
    process {
        try {
            $splatParams = @{
                Uri         = $Uri
                Headers     = $Headers
                Method      = $Method                
                Body        = $Body
            }
  
            $response = Invoke-RestMethod @splatParams 
            Write-Output $response
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}

try {    
    if (-Not($actionContext.DryRun -eq $true)) {
        
        if ($($actionContext.TemplateConfiguration.scriptFlow) -eq "SendSMS") {
            # Execute script flow SendSMS
            $endpoint = $actionContext.Configuration.baseUri

            $authHeaders = Set-AuthorizationHeaders -AccessKey $($actionContext.Configuration.accesskey) 
            
            $body = @{
                recipients = $actionContext.TemplateConfiguration.recipients
                originator = $actionContext.Configuration.originator
                body       = $actionContext.TemplateConfiguration.body                
            } | ConvertTo-Json

            $splatParams = @{
                Method = "Post"
                Uri = $endpoint
                Headers = $authHeaders
                Body = $body 
            }
            $response = Invoke-MessageBirdRestMethod @splatParams

            $outputContext.AuditLogs.Add([PSCustomObject]@{
                Message = "Sending notification [$($actionContext.TemplateConfiguration.scriptFlow)] for [$($personContext.Person.DisplayName)] with number [$($response.id)] was successful."
                IsError = $false
            })


        } else {
            # Execute script flow two
        }
    }
} catch {
    $ex = $PSItem    
    Write-Verbose -Verbose $ex.Exception.Message
    switch ($ex.Exception.Message) {       
        'Incorrect scriptFlow' {
            $errorMessage = "Incorrect scriptFlow [$($actionContext.TemplateConfiguration.scriptFlow)]"
        }
        
        default {
            Write-Verbose ($ex | ConvertTo-Json) # Debug - Test
            if ($($ex.Exception.GetType().FullName -eq 'Microsoft.PowerShell.Commands.HttpResponseException') -or
                $($ex.Exception.GetType().FullName -eq 'System.Net.WebException')) {
                $errorMessage = "Could not send MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]. Error: $($ex.ErrorDetails.Message)"
            }
            else {
                $errorMessage = "Could not send MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]. Error: $($ex.Exception.Message) $($ex.ScriptStackTrace)"
            } 
            $outputContext.AuditLogs.Add([PSCustomObject]@{
                    Message = $errorMessage
                    IsError = $true
                })
        }
    }
} finally {
    $message = "Error in sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)]."    
    $isError = $true
    
    # Check if auditLogs contains errors, if no errors are found, set success to true
    if (-NOT($outputContext.AuditLogs.isError -contains $true)) {
        $message = "Sending MessageBird notification [$($actionContext.TemplateConfiguration.scriptFlow)] for: [$($personContext.Person.DisplayName)] finished."
        $isError = $false
        $success = $true
    }

    $outputContext.AuditLogs.Add([PSCustomObject]@{
        Message = $message
        IsError = $isError
    })
    $outputContext.Success = $success
}


