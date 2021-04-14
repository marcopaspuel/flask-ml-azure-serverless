setup:
	python3 -m venv ~/.flask-ml-azure-serverless
	#source ~/.flask-ml-azure-serverless/bin/activate
	
install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	python -m pytest -vv test_hello.py

lint:
	pylint --disable=R,C hello.py

all: install lint test