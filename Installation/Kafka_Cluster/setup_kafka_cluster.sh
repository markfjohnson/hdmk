#!/usr/bin/env bash
dcos package install --yes kafka
dcos kafka endpoints broker

