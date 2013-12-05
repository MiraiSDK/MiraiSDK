
#import <stdio.h>
#import "Fraction.h"
#import <Foundation/Foundation.h>

int  main( int argc, const char *argv[] ) {
	printf("main start\n");
    [NSAutoreleasePool new];
	
    // create a new instance
    Fraction *frac = [[Fraction alloc] init];

    // set the values
    [frac setNumerator: 1];
    [frac setDenominator: 3];

    // print it
    printf( "The fraction is: " );
    [frac print];
    printf( "\n" );

    // free memory
    [frac release];
	
	NSLog(@"nslog: hello");

    return 0;
}

