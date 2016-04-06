FILES :=                              \
    .gitignore                        \
    .travis.yml                       \
    makefile                          \
    apiary.apib                       \
    IDB2.log                          \
    models.html                       \
    ./app/models.py                   \
    ./app/tests.py                    \
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

test: ./app/tests.py
	coverage3 run    --branch ./app/tests.py >  tests.tmp 2>&1
	coverage3 report -m --omit=/usr/local/lib/python3.4/dist-packages/*,/home/travis/virtualenv/python3.4.2/lib/python3.4/site-packages/* >> tests.tmp
	cat tests.tmp

IDB2.log:
	git log > IDB2.log

models.html: ./app/models.py
	pydoc -w ./app/models

# Variables needed for the docker-* targets
IMAGE_PREFIX := cs373idb
DOCKER_HUB_USERNAME := $(IMAGE_PREFIX)

APP_FILES:=                     \
    ./app/app.py                \
    ./app/constants.py          \
    ./app/constraints.py        \
    ./app/enums.py              \
    ./app/IngredientQueries.py  \
    ./app/models.py             \
    ./app/QueryExceptions.py    \
    ./app/QueryHelpers.py       \
    ./app/RecipeQueries.py      \
    ./app/testModels.py         \
    ./app/tests.py              \
    ./app/useDatabase.py        \
    ./app/Dockerfile            \
    ./app/requirements.txt      \

DB_FILES:=          \
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

docker-build-all: docker-build-lb docker-build-app docker-build-db

docker-deploy:
	docker-compose down
	docker-compose --file docker-compose-prod.yml up -d

