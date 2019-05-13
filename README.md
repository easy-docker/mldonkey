# mldonkey docker image
```
docker pull ghostry/mldonkey
docker container stop gmldonkey
docker container rm gmldonkey
docker run -d -v ~/.gmldonkey:/var/lib/mldonkey -v ~/Downloads:/incoming -p 4001:4001 -p 4080:4080 --restart always --name gmldonkey --user $(id -u):$(id -g) ghostry/mldonkey
```
临时文件可以使用`-v /temp:/temp`参数映射出来

4001是客户端端口,4080是web界面端口,按需映射