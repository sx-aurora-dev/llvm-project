pipeline {
    agent any
    environment {
        // PATH for aurora-ds02
        PATH = "/proj/share/local/x86_64/cmake-3.18.4-Linux-x86_64/bin:$PATH"
        TOP = pwd()
        CMAKE = "cmake"
        PYTHON = "python3"
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

    stages {
        stage('Checkout LLVM') {
            steps {
                dir('llvm-project') {
                    checkout scm
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
                            THREADS= cmake build
                    """
                }
            }
        }
        stage('Check LLVM') {
            steps {
                dir('llvm-dev') {
                    sh """
                        make THREADS= check-clang check-llvm
                    """
                }
            }
        }
        stage('Install LLVM') {
            steps {
                dir('llvm-dev') {
                    sh """
                        make SRCDIR=${TOP}/llvm-project CMAKE=${CMAKE} THREADS=
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
                                ${CMAKE} -DCMAKE_BUILD_TYPE="Debug" \
                                    -DLLVM_DIR=${TOP}/llvm-dev/install/lib/cmake/llvm \
                                    -DNCC_VERSION=-3.0.6 ..
                                make -j
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
