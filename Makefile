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

rmPostgres:
	docker stop mfbuildfiles_postgres_1 && docker rm mfbuildfiles_postgres_1 && docker rmi postgres

rmProjections:
	docker stop mfbuildfiles_projections_1 && docker rm mfbuildfiles_projections_1 && docker rmi mfbuildfiles_projections

nodeContainer: 
	cd NodeImage && docker build -t mf/nodebox . && cd ..

stop:
	docker stop $(docker ps -aq)

remove:
	docker stop $(docker ps -aq) && docker rm $(docker ps -aq)

removeImages: 
	docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -aq)

cleanProjects:
	docker rm -f mfbuildfiles_domain_1 && docker rmi mfbuildfiles_domain && \
	docker rm -f mfbuildfiles_api_1 && docker rmi mfbuildfiles_api && \
	docker rm -f mfbuildfiles_postgres_1 && \
	docker rm -f mfbuildfiles_projections_1 && docker rmi mfbuildfiles_projections 

deploy:
	cd ../MF_Core && gulp && cd ../MF_Api && gulp deploy && cd ../MF_Domain && gulp deploy && cd ../MF_Projections && gulp deploy && cd ..

