format:
		isort -rc -y .
		black -l 79 .

test:
		pytest -n auto -vvv

envupdate:
		conda env update -f environment.yml

envupdatedev:
		conda env update -f environment.yml