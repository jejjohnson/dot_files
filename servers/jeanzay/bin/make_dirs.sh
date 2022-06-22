#!/bin/bash

echo "Checking for directories..."

# make directory for wandb logs
if [ ! -d $SCRATCH/logs ];
then
  mkdir -p $SCRATCH/logs;
else
  echo "Log directory already exists..."
fi

# make directory for wandb logs
if [ ! -d $SCRATCH/wandb ];
then
  mkdir -p $SCRATCH/wandb;
else
  echo "wandb directory already exists..."
fi

# make directory for wandb logs
if [ ! -d $SCRATCH/errs ];
then
  mkdir -p $SCRATCH/errs;
else
  echo "errs directory already exists..."
fi

# make directory for jobs logs
if [ ! -d $SCRATCH/jobs ];
then
  mkdir -p $SCRATCH/jobs;
else
  echo "jobs directory already exists..."
fi

# make dot files
if [ ! -d $SCRATCH/.cache ];
then
  mkdir -p $SCRATCH/.cache;
else
  echo "cache directory already exists..."
fi