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
                        make check-clang check-llvm
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
        stage('Checkout vetfkernel') {
            steps {
                dir('vetfkernel') {
                    git branch: 'master',
                        credentialsId: 'marukawa-token',
                        url: "${REPO_TOP_URL}/ve-tensorflow/vetfkernel.git"
                }
                dir('vetfkernel/libs/vednn') {
                    git branch: 'vetfkernel',
                        credentialsId: 'marukawa-token',
                        url: "${REPO_TOP_URL}/ve-tensorflow/vednn.git"
                }
            }
        }
        stage('Build vetfkernel') {
            steps {
                dir('vetfkernel/build') {
                    sh """
                        ${CMAKE} -DCMAKE_BUILD_TYPE="Debug" \
                            -DLLVM_DIR=${TOP}/llvm-dev/install/lib/cmake/llvm \
                            -DNCC_VERSION=-3.0.6 ..
                        make -j
                    """
                }
            }
        }
        stage('Check vetfkernel') {
            steps {
                dir('vetfkernel') {
                    sh """
                        ./build/test/test01
                        ${PYTHON} perf.py -e build/test/bench -d perfdb/10B \
                            test
                    """
                }
            }
        }
    }
}
