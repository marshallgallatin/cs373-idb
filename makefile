FILES :=                              \
    .gitignore                        \
    .travis.yml                       \
    makefile                          \
    apiary.apib                       \
    IDB1.log                          \
    models.html                        \
    models.py                         \
    tests.py                          \
    UML.pdf

check:
	@not_found=0;                                 \
    for i in $(FILES);                            \
    do                                            \
        if [ -e $$i ];                            \
        then                                      \
            echo "$$i found";                     \
        else                                      \
            echo "$$i NOT FOUND";                 \
            not_found=`expr "$$not_found" + "1"`; \
        fi                                        \
    done;                                         \
    if [ $$not_found -ne 0 ];                     \
    then                                          \
        echo "$$not_found failures";              \
        exit 1;                                   \
    fi;                                           \
    echo "success";

clean:
	rm -f  .coverage
	rm -f  *.pyc
	rm -rf __pycache__

config:
	git config -l

scrub:
	make clean
	rm -f  model.html
	rm -f  IDB1.log

status:
	make clean
	@echo
	git branch
	git remote -v
	git status

test: tests.py
	coverage3 run    --branch tests.py >  tests.tmp 2>&1
	coverage3 report -m                >> tests.tmp
	cat tests.tmp

IDB1.log:
	git log > IDB1.log
	
models.html: models.py
	pydoc -w models

# Variables needed for the docker-* targets
IMAGE_PREFIX := cs373idb
DOCKER_HUB_USERNAME := marshallgallatin

APP_FILES:=                    \
    ./app/app.py               \
    ./app/Dockerfile           \
    ./app/requirements.txt     \

DB_FILES:=          \
    ./db/mysql.cnf  \
    ./db/Dockerfile \

docker-build-lb:
	docker build -t $(DOCKER_HUB_USERNAME)/$(IMAGE_PREFIX)_lb  lb
	docker push $(DOCKER_HUB_USERNAME)/$(IMAGE_PREFIX)_lb

docker-build-app: $(APP_FILES)
	docker build -t $(DOCKER_HUB_USERNAME)/$(IMAGE_PREFIX)_app  app
	docker push $(DOCKER_HUB_USERNAME)/$(IMAGE_PREFIX)_app

docker-build-db: $(DB_FILES)
	docker build -t $(DOCKER_HUB_USERNAME)/$(IMAGE_PREFIX)_db  db
	docker push $(DOCKER_HUB_USERNAME)/$(IMAGE_PREFIX)_db

docker-deploy: docker-build-lb docker-build-app docker-build-db
	docker-compose down
	docker-compose --file docker-compose-prod.yml up -d

