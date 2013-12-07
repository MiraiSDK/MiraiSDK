#!/bin/bash

pushd `pwd`/`dirname $0`
PRODUCT_ROOT=`pwd`
popd

# link platform
echo "Link Android.platform to Xcode..."
#ln -s ${PRODUCT_ROOT}/Xcode/Platforms/Android.platform /Applications/Xcode.app/Contents/Developer/Platforms/Android.platform

# create Specifications
echo "Create Specifications..."
template='''
(
    {
        Identifier = org.tiny4.compilers.android.clang.3.3;
        BasedOn    = com.apple.compilers.llvm.clang.1_0;
        Name       = "Android Clang 3.3";
        Version    = "org.tiny4.compilers.android.clang.3.3";
        Vendor     = "org.tiny4";
        ExecPath   = "PRODUCT_ROOT/android-toolchain-arm/bin/arm-linux-androideabi-clang";
        Architectures = (i386);

        SupportsZeroLink              = No;
        SupportsPredictiveCompilation = No;
        SupportsHeadermaps            = Yes;
        DashIFlagAcceptsHeadermaps    = Yes;

        Options = (
        {
            Name = SDKROOT;
            Type = Path;
            CommandLineArgs = ();
        },

        );

    }
)
'''

generated=${template/PRODUCT_ROOT/$PRODUCT_ROOT}
echo "$generated" > ~/Library/Application\ Support/Developer/Shared/Xcode/Specifications/android-clang-3.3.pbcompspec