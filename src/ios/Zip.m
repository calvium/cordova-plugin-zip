#import "Zip.h"

@implementation Zip

- (void)unzip:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        
        @try {
            
            // Need to prepend src with path to Documents folder
            NSString *zipPath = [command.arguments objectAtIndex:0] ;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *srcPath = [documentsDirectory stringByAppendingPathComponent:zipPath];
            
            // Need to prepend dest with path to Documents folder
            NSString *destinationPath = [command.arguments objectAtIndex:1];
            NSString *destFolder = [documentsDirectory stringByAppendingPathComponent:destinationPath];

            NSError *error;
            if([SSZipArchive unzipFileAtPath:srcPath toDestination:destFolder overwrite:YES password:nil error:&error]) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsString:destFolder];
            } else {
                NSLog(@"%@ - %@", @"Error occurred during unzipping", [error localizedDescription]);
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error occurred during unzipping"];
            }
        } @catch(NSException* exception) {
            NSLog(@"%@ - %@", @"Error occurred during unzipping", [exception debugDescription]);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error occurred during unzipping"];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)docRoot:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;

        @try {

            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsString:documentsDirectory];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        @catch(NSException* exception) {
            NSLog(@"%@ - %@", @"Error occurred during unzipping", [exception debugDescription]);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error occurred during unzipping"];
        }
    }];
}

@end
