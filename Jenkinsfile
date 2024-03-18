pipeline {
    agent any
    environment {
        TOP = pwd()
        // LLVM requires cmake newer than 3.20
        CMAKE = "/proj/share/local/x86_64/cmake-3.26.4-linux-x86_64/bin/cmake"
        // VML requires cmake older than 3.20
        CMAKEO = "/proj/share/local/x86_64/cmake-3.18.4-Linux-x86_64/bin/cmake"
        PYTHON = "python3"
        // Job pool
        COMPILE_THREADS = 24
        LINK_THREADS = 8
        // URL
        REPO_URL = sh(
            returnStdout: true,
            script: "echo ${env.GIT_URL} | sed -e 's:/[^/]*\$::'").trim()
        REPO_TOP_URL = sh(
            returnStdout: true,
            script: "echo ${env.GIT_URL} | sed -e 's:/[^/]*/[^/]*\$::'").trim()

        // Use VE 0 or 2.
        VE_NODE_NUMBER = sh(
            returnStdout: true,
            script: "echo ${env.EXECUTOR_NUMBER} | sed -e 's:1:2:'").trim()
    }
    options {
        timeout(time: 2, unit: 'HOURS')
    }

    stages {
        stage('Checkout LLVM') {
            steps {
                dir('llvm-project') {
                    // checkout scm
                    checkout([
                      $class: 'GitSCM',
                      branches: scm.branches,
                      doGenerateSubmoduleConfigurations:
                        scm.doGenerateSubmoduleConfigurations,
                      extensions: [[
                        $class: 'CloneOption',
                        noTags: true,
                        reference: '',
                        shallow: true
                      ]],
                      userRemoteConfigs: scm.userRemoteConfigs
                    ])
                }

                dir('llvm-dev') {
                    git branch: 'develop',
                        credentialsId: 'marukawa-token',
                        url: "${REPO_URL}/llvm-dev.git"
                }
            }
        }
        stage('Build LLVM') {
            steps {
                dir('llvm-dev') {
                    sh """
                        make clean
                        make SRCDIR=${TOP}/llvm-project CMAKE=${CMAKE} \
                            COMPILE_THREADS=${COMPILE_THREADS} \
                            LINK_THREADS=${LINK_THREADS} cmake build
                    """
                }
            }
        }
        stage('Check LLVM') {
            steps {
                dir('llvm-dev') {
                    sh """
                        make COMPILE_THREADS=${COMPILE_THREADS} \
                            LINK_THREADS=${LINK_THREADS} check-clang check-llvm
                    """
                }
            }
        }
        stage('Install LLVM') {
            steps {
                dir('llvm-dev') {
                    sh """
                        make SRCDIR=${TOP}/llvm-project CMAKE=${CMAKE} \
                            COMPILE_THREADS=${COMPILE_THREADS} \
                            LINK_THREADS=${LINK_THREADS}
                    """
                }
            }
        }
        stage('Run additional tests') {
            parallel {
                stage('Test intrinsic instructions') {
                    steps {
                        dir('intrinsic') {
                            git branch: 'master',
                                credentialsId: 'marukawa-token',
                                url: "${REPO_URL}/llvm-ve-intrinsic-test.git"
                            sh """
                                make clean
                                make CLANG=${TOP}/llvm-dev/install/bin/clang -j
                                ./test.sh
                            """
                        }
                    }
                }
                stage('Prepare vml') {
                    steps {
                        dir('vml') {
                            git branch: 'master',
                                credentialsId: 'marukawa-token',
                                url: "${REPO_TOP_URL}/ve-tensorflow/vml.git"
                            // Remove build directory to perform clean-build
                            sh """
                                rm -rf build
                            """
                        }
                        dir('vml/libs/vednn') {
                            git branch: 'vml',
                                credentialsId: 'marukawa-token',
                                url: "${REPO_TOP_URL}/ve-tensorflow/vednn.git"
                        }
                        dir('vml/build') {
                            sh """
                                VERSION=`grep 'set.*LLVM_VERSION_MAJOR  *' ${TOP}/llvm-project/cmake/Modules/LLVMVersion.cmake | sed -e 's/.*LLVM_VERSION_MAJOR //' -e 's/[^0-9][^0-9]*//'`
                                ${CMAKEO} -DCMAKE_BUILD_TYPE="Debug" \
                                    -DLLVM_DIR=${TOP}/llvm-dev/install/lib/cmake/llvm \
                                    -DCLANG_RUNTIME=${TOP}/llvm-dev/install/lib/clang/\${VERSION}/lib/ve-unknown-linux-gnu/libclang_rt.builtins.a \
                                    -DNCC_VERSION=-3.0.6 ..
                                # make -j often crash
                                make -j${COMPILE_THREADS}
                            """
                        }
                    }
                }
            }
        }
        stage('Check vml') {
            steps {
                dir('vml/build') {
                    sh """
                        make test
                        ${PYTHON} ../perf.py -e bench/bench -d ../perfdb/10B \
                            test
                    """
                }
            }
        }
    }
}
