//
//  saverwatch.m
//  test
//
//  Created by gm on 10/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "saverwatch.h"


@implementation saverwatch

- (id)init
{
    self = [super init];
    if (self) {
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                            selector:@selector(screenSaverDidStart:)
                                                                name:@"com.apple.screensaver.didstart" object:nil];
        
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                            selector:@selector(screenSaverDidStop:)
                                                                name:@"com.apple.screensaver.didstop" object:nil];    }
    NSLog(@"init");
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) screenSaverDidStart:(NSNotification *) notification {
    task = [[NSTask alloc] init];
    [task setCurrentDirectoryPath:[@"~/" stringByExpandingTildeInPath]];
    [task setLaunchPath:@"/path/to/script"];
    [task setArguments:[NSArray arrayWithObject:@"test"]];
    
    NSPipe *outPipe = [NSPipe pipe];
    [task setStandardOutput:outPipe];
    [task setStandardInput:[NSPipe pipe]];
    
    [task launch];
}

- (void) screenSaverDidStop:(NSNotification *) notification {
    if (task) {
        [task terminate];
    }
    [task release];
}

@end
