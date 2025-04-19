<h1>PSServiceChecker - Powershell Service Checker & Email Alert</h1>

<h2>Description</h2>
Project consists of a simple Powershell script, CSV for storing services/statuses desired and an XML file for storing email credentials which must be generated. It will check the status of each service that is listed and log the current status. If the status is different from the desired one, the script will attempt to set the service to the correct status and will send an email alert with the results.
<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 

<h2>Environments Used </h2>

- <b>Windows 11</b> (24H2)

<h2>Script walk-through:</h2>

<p align="center">
In the project directory, run '$credential = Get-Credential', enter your email username and password: <br/>
<img src="https://i.imgur.com/8dV3DHZ.png" height="80%" width="80%" alt="PSServiceChecker Steps"/>
<br />
<br />
Now in the project directory, run '$credential | Export-Clixml -Path ".\emailcred.xml"': <br/>
<img src="https://i.imgur.com/ftqM99P.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Open 'servicechecker.ps1', change the circled fields to the appropriate values for your email configuration: <br/>
<img src="https://i.imgur.com/fb0umsh.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Now open 'services.csv' and change the 'Name' and 'Status' values to the services you want to check and the desired status: <br/>
<img src="https://i.imgur.com/lACb9wp.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Now open Powershell as administrator and run the script: <br/>
<img src="https://i.imgur.com/CSncV0i.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
You can see the output in log.txt: <br/>
<img src="https://i.imgur.com/SEtZGcu.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
You will receive an email like this showing the service which was stopped and if it successfully started: <br/>
<img src="https://i.imgur.com/9uVcW0K.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
</p>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>