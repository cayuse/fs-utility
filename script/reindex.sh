#!/bin/bash
cd /home/shared/fs-utility
RAILS_ENV='production' rake ts:index
RAILS_ENV='production' rake ts:rebuild
cp config/production.sphinx.conf config/development.sphinx.conf
cp config/production.sphinx.conf /home/shared/fs-utility/config/production.sphinx.conf
cp config/production.sphinx.conf /home/shared/fs-utility/config/development.sphinx.conf

