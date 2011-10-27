# Build script for Galaxy Tab P1000L/N
# Created by Ronan aka Ronis_BR
# Adapted from Overcome build scripts written
# by Frank aka AlterBridge86

# Building directory
BUILDDIR='../kernel-build-dir'

# Check if BUILDDIR exists, if not, create it.
if [ ! -e $BUILDDIR ];
then
        mkdir $BUILDDIR
fi

# Rename .git to avoid problems while building the
# kernel.
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

# Copy samsung modemctl driver that was built with
# 2009q03 toolchain to avoid issues.
cd ./drivers/misc/samsung_modemctl/
make
cd ../../../

if [ ! -e ${BUILDDIR}/drivers/misc/samsung_modemctl ];
then
       mkdir ${BUILDDIR}/drivers/misc/samsung_modemctl
fi

mv ./drivers/misc/samsung_modemctl/built-in.o ${BUILDDIR}/drivers/misc/samsung_modemctl/

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
