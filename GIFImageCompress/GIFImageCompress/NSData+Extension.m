//
//  NSData+Extension.m
//  GIFImageCompress
//
//  Created by hanbo on 2019/2/26.
//  Copyright © 2019 hanbo. All rights reserved.
//

#import "NSData+Extension.h"

@implementation NSData (Extension)

- (NSString *)transformedValue{
    
    double convertedValue = [[NSNumber numberWithInteger:self.length] doubleValue];
    
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB",nil];
    
    while (convertedValue > 1024) {
        
        convertedValue /= 1024;
        
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}


@end
