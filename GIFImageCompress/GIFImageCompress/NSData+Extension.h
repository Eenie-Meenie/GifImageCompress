//
//  NSData+Extension.h
//  GIFImageCompress
//
//  Created by hanbo on 2019/2/26.
//  Copyright © 2019 hanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Extension)


/**
 字节数转换成KB
 
 @return 例如 200KB
*/
- (NSString *)transformedValue;

@end

NS_ASSUME_NONNULL_END
