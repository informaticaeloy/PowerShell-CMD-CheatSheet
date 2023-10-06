 ```shell
Invoke-Command -ComputerName nombre_del_equipo {Get-ItemProperty -Path 'HKLM:\SOFTWARE\Teamviewer\' -Name ClientID} | select ClientID
```

![image](https://github.com/informaticaeloy/PowerShell-CMD-CheatSheet/assets/20743678/ab92a167-6538-408d-8fe7-0951565dea46)
