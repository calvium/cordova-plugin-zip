#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "SSZipArchive.h"

@interface Zip : CDVPlugin

- (void)unzip:(CDVInvokedUrlCommand*)command;
- (void)docRoot:(CDVInvokedUrlCommand*)command;

@end
