# -*- mode:makefile; coding:utf-8 -*-

# Copyright (c) 2020 IBM Corp. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


develop:
	pip install -e .[dev] --upgrade --upgrade-strategy eager
	pre-commit install
	pre-commit autoupdate

install:
	pip install  --upgrade pip setuptools
	pip install . --upgrade --upgrade-strategy eager

code-format:
	pre-commit run yapf --all-files
	pre-commit run mdformat --all-files

code-lint:
	pre-commit run flake8 --all-files

test::
	python -m pytest --cov trestle test -v

deploy::
	git config --global user.name "semantic-release (via TravisCI)"
	git config --global user.email "semantic-release@travis"
	semantic-release publish

serve::
	python -m compliance_trestle_flask_demo
