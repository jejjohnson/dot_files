.PHONY: conda format style types black test link check notebooks
.DEFAULT_GOAL = help

PYTHON = python
VERSION = 3.8
NAME = py_name
ROOT = root_folder
PIP = pip
CONDA = conda
SHELL = bash

help:
		@printf "Usage:\n"
		@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1;34mmake %-10s\033[0m%s\n", $$1, $$2}'

conda:  # setup a conda environment for development
		@printf "Creating conda environment...\n"
		${CONDA} create env create -f environment.yml
		@printf "\n\nConda environment created! \033[1;34mRun \`conda activate ${NAME}\` to activate it.\033[0m\n\n\n"

format: # CODE STYLE - BLACK, ISORT
		black --check --diff ${ROOT} tests
		@printf "\033[1;34mBlack passes!\033[0m\n\n"
		isort ${ROOT}/ tests/
		@printf "\033[1;34misort passes!\033[0m\n\n"

style:  # STYLES
		@printf "Checking code style with pylint...\n"
		pylint ${ROOT}/
		@printf "\033[1;34mPylint passes!\033[0m\n\n"

types:
		@printf "Checking code type signatures with mypy...\n"
		python -m mypy --ignore-missing-imports ${ROOT}/
		@printf "\033[1;34mMypy passes!\033[0m\n\n"

black:  # Format code in-place using black.
		black ${ROOT}/ tests/

notebooks: notebooks/*
		jupyter nbconvert --config nbconfig.py --execute --ExecutePreprocessor.kernel_name="pymc4-dev" --ExecutePreprocessor.timeout=1200
		rm notebooks/*.html

test:  # Test code using pytest.
		pytest -v pymc4 tests --doctest-modules --html=testing-report.html --self-contained-html

lint: docstyle format style types  # Lint code using pydocstyle, black, pylint and mypy.

check: lint test  # Both lint and test code. Runs `make lint` followed by `make test`.