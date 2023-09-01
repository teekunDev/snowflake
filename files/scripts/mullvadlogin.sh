#!/usr/bin/env bash

ACCOUNT=$(cat $NIXOS_SECRETS/mullvad_account);
mullvad account login $ACCOUNT
