NAME=mf/api
SHELL := /bin/zsh

pull:
	git pull origin master && \
	cd ../MF_Api && git pull origin master && \
	cd ../MF_Core && git pull origin master && \
	cd ../MF_Domain && git pull origin master && \
	cd ../MF_FrontEnd && git pull origin master && \
	cd ../MF_Projections && git pull origin master && cd ../MF_BuildFiles; 
	
comAndPush:
	git com "commit and push"; git push origin master; \
	cd ../MF_Api && git com "commit and push"; git push origin master; \
	cd ../MF_Core && git com "commit and push"; git push origin master; \
	cd ../MF_Domain && git com "commit and push"; git push origin master; \
	cd ../MF_FrontEnd && git com "commit and push"; git push origin master; \
	cd ../MF_Projections && git com "commit and push"; git push origin master; cd ../MF_BuildFiles;

rmDomain:
	docker stop mfbuildfiles_domain_1 && docker rm mfbuildfiles_domain_1 && docker rmi mfbuildfiles_domain

rmApi:
	docker stop mfbuildfiles_api_1 && docker rm mfbuildfiles_api_1 && docker rmi mfbuildfiles_api

nodeContainer: 
	cd NodeImage && docker build -t mf/nodebox . && cd ..

stop:
	docker stop $(docker ps -aq)

remove:
	docker stop $(docker ps -aq) && docker rm $(docker ps -aq)

removeImages: 
	docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -aq)

