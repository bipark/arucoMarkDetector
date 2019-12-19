//
//  MarkDetector.h
//  MarkDetector
//
//  Created by Park Billy on 19/12/2019.
//  Copyright © 2019 Park Billy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarkDetector : NSObject

+ (NSString *) openCVVersionString;
+ (NSDictionary *) findMark:(UIImage *) source;


@end

NS_ASSUME_NONNULL_END

