#!/usr/bin/env bash

# target image name (fully qualified) to be build with s2i, redeclaring the same parameter name than
# buildah task uses
declare -x PARAMS_IMAGE="${PARAMS_IMAGE:-}"
# Specify a URL containing the default assemble and run scripts for the builder image
declare -rx PARAMS_IMAGE_SCRIPTS_URL="${PARAMS_IMAGE_SCRIPTS_URL:-}"

# volume mount or directory responsible for holding files 
# like env, Dockerfile and any others needed to support s2i
declare -rx S2I_GENERATE_DIRECTORY="${S2I_GENERATE_DIRECTORY:-/s2i-generate}"

# full path to the container file generated by s2i
declare -rx S2I_DOCKERFILE="${S2I_DOCKERFILE:-${S2I_GENERATE_DIRECTORY}/Dockerfile.gen}"

# full path to the env file used with the --environment-file parameter of s2i
declare -rx S2I_ENVIRONMENT_FILE="${S2I_ENVIRONMENT_FILE:-${S2I_GENERATE_DIRECTORY}/env}"

#
# Asserting Environment
#

exported_or_fail \
    WORKSPACES_SOURCE_PATH \
    PARAMS_IMAGE

#
# Verbose Output
#

declare -x S2I_LOGLEVEL="0"

if [[ "${PARAMS_VERBOSE}" == "true" ]]; then
    S2I_LOGLEVEL="2"
    set -x
fi
