#!/usr/bin/env bash

declare -rx PARAMS_IMAGE="${PARAMS_IMAGE:-}"
declare -rx PARAMS_DOCKERFILE="${PARAMS_DOCKERFILE:-}"
declare -x PARAMS_CONTEXT="${PARAMS_CONTEXT:-}"
declare -rx PARAMS_STORAGE_DRIVER="${PARAMS_STORAGE_DRIVER:-}"
declare -rx PARAMS_BUILD_EXTRA_ARGS="${PARAMS_BUILD_EXTRA_ARGS:-}"
declare -rx PARAMS_PUSH_EXTRA_ARGS="${PARAMS_PUSH_EXTRA_ARGS:-}"
declare -rx PARAMS_SKIP_PUSH="${PARAMS_SKIP_PUSH:-}"
declare -rx PARAMS_TLS_VERIFY="${PARAMS_TLS_VERIFY:-}"
declare -rx PARAMS_VERBOSE="${PARAMS_VERBOSE:-}"

declare -rx WORKSPACES_SOURCE_PATH="${WORKSPACES_SOURCE_PATH:-}"
declare -rx WORKSPACES_SOURCE_BOUND="${WORKSPACES_SOURCE_BOUND:-}"
declare -rx WORKSPACES_DOCKERCONFIG_PATH="${WORKSPACES_DOCKERCONFIG_PATH:-}"
declare -rx WORKSPACES_DOCKERCONFIG_BOUND="${WORKSPACES_DOCKERCONFIG_BOUND:-}"
declare -rx WORKSPACES_RHEL_ENTITLEMENT_PATH="${WORKSPACES_RHEL_ENTITLEMENT_PATH:-}"
declare -rx WORKSPACES_RHEL_ENTITLEMENT_BOUND="${WORKSPACES_RHEL_ENTITLEMENT_BOUND:-}"

declare -rx RESULTS_IMAGE_DIGEST_PATH="${RESULTS_IMAGE_DIGEST_PATH:-}"
declare -rx RESULTS_IMAGE_URL_PATH="${RESULTS_IMAGE_URL_PATH:-}"

#
# Dockerfile
#

# Exposing the full path to the container file, which by default should be relative to the primary
# workspace, with a fallback to be relative to the context directory.
if [[ -z "$DOCKERFILE_FULL" ]]; then
    if [[ -r "${WORKSPACES_SOURCE_PATH}/${PARAMS_DOCKERFILE}" ]]; then
        declare -x DOCKERFILE_FULL="${WORKSPACES_SOURCE_PATH}/${PARAMS_DOCKERFILE}"
    else
        declare -x DOCKERFILE_FULL="${WORKSPACES_SOURCE_PATH}/${PARAMS_CONTEXT}/${PARAMS_DOCKERFILE}"
    fi
fi

#
# Asserting Environment
#

[[ ! -r "${DOCKERFILE_FULL}" ]] &&
    fail "unable to find the Dockerfile, DOCKERFILE may have an incorrect location"

exported_or_fail \
    WORKSPACES_SOURCE_PATH \
    PARAMS_IMAGE

#
# Verbose Output
#

if [[ "${PARAMS_VERBOSE}" == "true" ]]; then
    set -x
fi
