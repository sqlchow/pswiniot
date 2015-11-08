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
        $Uri
    )

    Begin
    {
    }
    Process
    {
            #Create httpclient object
            $httpclient = new-object system.net.http.httpclient
            $httpclient.GetStringAsync($Uri).Result
    }
    End
    {
    }
}