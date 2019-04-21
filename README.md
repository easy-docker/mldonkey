# mldonkey docker image

    docker run -d -v /data/mldonkey:/var/lib/mldonkey -v ~/Downloads:/incoming -p 4001:4001 -p 4080:4080 --restart always --name gmldonkey ghostry/mldonkey

临时文件可以使用`-v /temp:/temp`参数映射出来

4001是客户端端口,4080是web界面端口,按需映射