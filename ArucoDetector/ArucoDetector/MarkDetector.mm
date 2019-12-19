//
//  MarkDetector.mm
//  MarkDetector
//
//  Created by Park Billy on 19/12/2019.
//  Copyright © 2019 Park Billy. All rights reserved.
//

#import "MarkDetector.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/aruco.hpp>


@implementation MarkDetector

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}


@end

