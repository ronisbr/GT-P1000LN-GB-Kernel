# Build script for Galaxy Tab P1000L/N
# Created by Ronan aka Ronis_BR
# Adapted from Overcome build scripts written
# by Frank aka AlterBridge86

# Building directory
BUILDDIR='../kernel-build-dir'

# For some reason, the Kernel doesn't boot if
# there is a .git directory with commits by the
# time it was built.
# So it moves .git to .gitold, builds the kernel
# and then move it back to .git.
if [ -d ".git" ];
then
	mv .git .gitold
fi

# If exists, rename .config to avoid problems and
# copy it to build directory.
if [ -e .config ];
then
	cp .config ${BUILDDIR}/
	mv .config .config.bak
fi

# Execute oldconfig.
make O=${BUILDDIR} oldconfig

# Build the kernel.
make O=${BUILDDIR}

# Restore .config if needed.
if [ -e .config.bak ];
then
	mv .config.bak .config
fi

if [ -d ".gitold" ];
then
	mv .gitold .git
fi
