#!/usr/bin/env bash

set -e

if [ -z "${INPUT_OPERATION}" ]; then
          echo "Required variable \`operation\` is missing"
            exit 1
    fi
    # fail if INPUT_COMMAND is not set
    if [ -z "${INPUT_COMMAND}" ]; then
              echo "Required variable \`command\` is missing"
                exit 1
        fi

        if [ -n "${INPUT_WORKING_DIRECTORY}" ]; then
                  cd "${INPUT_WORKING_DIRECTORY}"
          fi

          # assemble operation
          if [ -z "${INPUT_ARGUMENTS}" ]; then
                    OPERATION="${INPUT_OPERATION} ${INPUT_COMMAND}"
            else
                      OPERATION="${INPUT_OPERATION} ${INPUT_COMMAND} ${INPUT_ARGUMENTS}"
              fi

              TARGETS=(${INPUT_TARGET})
              if [ -n "$TARGETS" ]; then

                      # iterate over target(s)
                        for TARGET in "${TARGETS[@]}"; do
                                    echo "::debug:: Processing target ${TARGET}"

                                        # shellcheck disable=SC2086
                                            ${OPERATION} "${TARGET}"
                                                done
                                                  else
                                                              echo "::debug:: Executing command: ${OPERATION}"
                                                                  $OPERATION
                                                                   fi
