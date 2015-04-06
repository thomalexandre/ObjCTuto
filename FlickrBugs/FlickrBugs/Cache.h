//
//  Cache.h
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cache : NSObject

+ (instancetype)sharedCache;
- (UIImage *)imageForKey:(NSString *)key;
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (void)downloadImageAtURL:(NSURL *)url completionHandler:(void (^)(UIImage *image))completion;

@end
