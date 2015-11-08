# PowerShell WinIoT Module
PowerShell Module for Windows 10 IoT (WinIoT)

- 11/08/2015: Initial version

# What is Windows 10 IoT?
Source: Windows Blog (http://blogs.windows.com/windowsexperience/2015/03/18/windows-10-iot-powering-the-internet-of-things/)
Windows 10 IoT will power a range of intelligent, connected IoT devices. From small devices like gateways, to mobile point- of- sale to powerful industry devices like robotics and specialty medical devices, Windows 10 IoT offers a converged platform for devices with enterprise-grade security from the device to the cloud, and native connectivity for machine-to-machine and machine-to-cloud scenarios with Azure IoT Services.

# Why this module?
I've WinIoT running on my RaspberryPi 2 and at this moment there are no invoke-restmethod or invoke-webrequest cmdlets available on WinIoT.
The only way I found to send HTTP requests and receive HTTP responses is using the HttpClient .Net Class (https://msdn.microsoft.com/en-us/library/system.net.http.httpclient(v=vs.118).aspx)
The first function in this PowerShell module should emulate the invoke-webrequest cmdlet from the Microsoft.PowerShell.Utility module.
