$scriptPath = Split-Path $MyInvocation.MyCommand.Path -Parent
$scriptPath = Split-Path $scriptPath -Parent

$MainPath = $scriptPath + "\jupyter"
Set-Location -Path $MainPath
Write-Host "Set-Location: " + $MainPath

docker rm $(docker stop $(docker ps -a -q --filter ancestor="jupyter/datascience-notebook" --format="{{.ID}}"))

$volume = $MainPath + ":" + "/home/jovyan/work"
docker run -it --rm -p 4545:8888 -e JUPYTER_ENABLE_LAB=yes -v $volume jupyter/datascience-notebook start.sh jupyter lab --LabApp.token='' --NotebookApp.custom_display_url="http://localhost:4545"