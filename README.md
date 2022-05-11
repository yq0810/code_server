# code-dev
这是一个基于code_server的开发环境，开箱即用。

运行

	docker run -td --restart=always --name code --net xxx --privileged -p 8080:8080 -u root -v "xxx:/home/project" xingzhao0401/code-dev

v2.0:\
golang python npm yarn

v1.0:\
golang python插件
