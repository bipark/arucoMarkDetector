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

+ (NSDictionary *) findMark:(UIImage *) source {
    
    bool found = false;
    NSDictionary *retdic;
    cv::Mat srcMat, returnMat;
    std::vector<int> markerIds;
    std::vector<std::vector<cv::Point2f>> markerCorners;
    cv::Ptr<cv::aruco::Dictionary> dict;
    
    UIImageToMat(source, srcMat);
    if (srcMat.channels() != 1) {
        cv::cvtColor(srcMat, srcMat, cv::COLOR_BGR2GRAY);
    }
        
    for (int i=cv::aruco::DICT_4X4_50; i !=cv::aruco::DICT_ARUCO_ORIGINAL; i++) {
        dict = cv::aruco::getPredefinedDictionary(i);
        cv::aruco::detectMarkers(srcMat, dict, markerCorners, markerIds);

        if (markerIds.size() > 0 && markerCorners.size() > 0) {
            cv::cvtColor(srcMat, returnMat, cv::COLOR_GRAY2BGR);
            cv::aruco::drawDetectedMarkers(returnMat, markerCorners, markerIds);

            std::cout << markerIds.size() << std::endl;
            std::cout << markerCorners.size() << std::endl;
            found = true;
        }
    }
    
    if (found) {
        retdic = @{
            @"process": @0,
            @"image": MatToUIImage(returnMat)
        };
    } else {
        retdic = @{
            @"process": @1,
            @"image": MatToUIImage(srcMat)
        };
    }

    return retdic;
}


@end

