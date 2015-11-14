#[reflection.assembly]::LoadWithPartialName('System.Net.Http') #Disable comment when developing module on non WinIoT Machine.


function Invoke-WinIoTWebRequest
{
<#
.Synopsis
   Gets content from a web page on the Internet.
.DESCRIPTION
   The Invoke-WebRequest cmdlet sends HTTP, HTTPS, FTP, and FILE requests to a web page or web service. It parses the
   response and returns collections of forms, links, images, and other significant HTML elements.
.EXAMPLE
   $r = Invoke-WinIoTWebRequest -URI https://github.com/stefanstranger/pswiniot
   $r.AllElements | where {$_.innerhtml -like "*=*"} | Sort { $_.InnerHtml.Length } | Select InnerText -First 5
.EXAMPLE
   $testUri = 'https://en.wikipedia.org/w/api.php?action=query&prop=info&format=json'+
                                '&inprop=watched&titles=Main%20page'
   Invoke-WinIoTWebRequest -URI $testUri
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
    [CmdletBinding(DefaultParameterSetName='Default', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'https://github.com/stefanstranger/pswiniot/',
                  ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [uri]
        $Uri,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        $Body,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=2,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [switch]
        $Certificate,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=3,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String]
        $CertificateThumbprint,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=4,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String]
        $ContentType = 'application/x-www-form-urlencoded',
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=5,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=6, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=7, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('DELETE', 'GET', 'HEAD', 'POST', 'PUT')]
        [string]
        $Method = 'GET',
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=8, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [uri]
        $Proxy,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=9, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $ProxyCredentials,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=10, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [switch]
        $ProxyUseDefaultCredentials,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=10, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [switch]
        $UseDefaultCredentials,
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=11, 
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String]
        $UserAgent
    )

    Begin
    {
        $PSBoundParameters.GetEnumerator() | % { 
            Write-Verbose "Parameter: $_" 
        }

        [void][System.Reflection.Assembly]::LoadWithPartialName('System.Net.Http')

        $clientHandler = New-Object System.Net.Http.HttpClientHandler
        $request       = New-Object System.Net.Http.HttpRequestMessage
        $response      = New-Object System.Net.Http.HttpResponseMessage
        $completionOption = [System.Net.Http.HttpCompletionOption]::ResponseContentRead

        if($PSBoundParameters.ContainsKey('Uri')){
            $request.RequestUri = $Uri
        }

        if($PSBoundParameters.ContainsKey('Body')){
            $request.Content = `
                New-Object System.Net.Http.StringContent($Body, [Encoding]::UTF8, $ContentType)
        }

        if($PSBoundParameters.ContainsKey('Certificate')){
            $clientHandler.ClientCertificateOptions = `
                        [System.Net.Http.ClientCertificateOption]::Automatic
            <#
                Currently, did not find a way of adding certificate to httpclient.

                Found one way, it was too complicated.
                http://piotrwalat.net/client-certificate-authentication-in-asp-net-web-api-and-windows-store-apps/
                May not be required after all: 
                https://pfelix.wordpress.com/2012/12/16/using-httpclient-with-ssltls/

                changing from System.Security.Cryptography.X509Certificates.X509Certificate2 to switch

                try{
                    $clientCert = [System.Security.Cryptography.X509Certificates.X509Certificate `
                                ]::CreateFromCertFile($Certificate)
                }catch [ArgumentException]{
                    Write-Error -Message "The $Certificate parameter is null."
                }catch {
                    Write-Error -Message "Could not load $Certificate ."
                }
            #>
        }
        
        if($PSBoundParameters.ContainsKey('CertificateThumbprint')){
            # Need to figure this out.
            # Get-CertificateFromThumbPrint -Thumbprint $CertificateThumbprint
        }

        if($PSBoundParameters.ContainsKey('ContentType')){
            $mediatype = New-Object `
                                -TypeName System.Net.Http.Headers.MediaTypeWithQualityHeaderValue `
                                -ArgumentList $ContentType
        }

        if($PSBoundParameters.ContainsKey('Credential')){
            $useAltCredentails  = $true
            $networkCredentails = $Credential.GetNetworkCredential()
            $encodedByteArray   = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes( `
                                "$($networkCredentails.UserName):$($networkCredentails.Password)"))

            $clientHandler.PreAuthenticate = $true
        }

        if($PSBoundParameters.ContainsKey('Method')){
            switch ($Method)
            {
                {$_ -in 'GET','HEAD'} {
                    $request.Method = [System.Net.Http.HttpMethod]::Get
                 }
                'POST'   {
                    $request.Method = [System.Net.Http.HttpMethod]::Post
                 }
                'PUT'    {
                    $request.Method = [System.Net.Http.HttpMethod]::Put
                 }
                'DELETE' {
                    $request.Method = [System.Net.Http.HttpMethod]::Delete
                 }
                Default {
                    $request.Method = [System.Net.Http.HttpMethod]::Get
                 }
            }
        }

        if($PSBoundParameters.ContainsKey('Proxy')){
            #Need to figure this out as System.Net.WebProxy is not available
            #$clienthandler.Proxy = [System.Net.WebProxy]($Proxy)
            #$clientHandler.UseProxy = $true
        }
        if($PSBoundParameters.ContainsKey('ProxyCredentials')){
            #Need to figure this out as System.Net.WebProxy is not available
        }

        if($PSBoundParameters.ContainsKey('ProxyUseDefaultCredentials')){
            #Need to figure this out as System.Net.WebProxy is not available
        }

        if($PSBoundParameters.ContainsKey('UseDefaultCredentials')){
            $clientHandler.UseDefaultCredentials = $true
        }

        if($PSBoundParameters.ContainsKey('UserAgent')){
            $addUserAgent = $true
        }

    }
    Process
    {
            
            
            #
            $httpclient = New-Object -TypeName System.Net.Http.HttpClient -ArgumentList $clientHandler

            if($PSBoundParameters.ContainsKey('Headers')){
                foreach ($item in $Headers.Keys)
                {
                  if(-not $httpclient.DefaultRequestHeaders.Contains($item)){
                    $httpclient.DefaultRequestHeaders.Add($item, $Headers[$item])
                  }
                }
            }

            if($mediatype){
                $httpclient.DefaultRequestHeaders.Accept.Add($mediatype)
            }
                        
            if($addUserAgent){
                $httpclient.DefaultRequestHeaders.UserAgent.Add($UserAgent)
            }else{
                $httpclient.DefaultRequestHeaders.Add("User-Agent", "winIoT-webrequest")
            }

            if($useAltCredentails){
                $httpclient.DefaultRequestHeaders.Authorization = `
                    New-Object System.Net.Http.Headers.AuthenticationHeaderValue("Basic", $encodedByteArray)
                
            }

            
            #$httpclient.GetStringAsync($Uri).Result
            $response = $httpclient.SendAsync($request, $completionOption)
            
            while(-not $response.IsCompleted){
                Write-Verbose "Awaiting reponse: $($response.AsyncState)"
                
                $response.Wait()
                Write-Verbose "Sleeping for 200ms"
                Start-Sleep -Milliseconds 200
            }

            $response.Result.Content.ReadAsStringAsync().Result
    }
    End
    {
        $response.Dispose()
        $request.Dispose()
        $clientHandler.Dispose()
        $httpclient.Dispose()
    }
}