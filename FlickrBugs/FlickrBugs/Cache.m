//
//  Cache.m
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import "Cache.h"

@implementation Cache
{
    NSMutableDictionary *_cache;
}

+ (instancetype)sharedCache
{
    static id sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[[self class] alloc] init];
    });
    return sharedCache;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)memoryWarning:(NSNotification *)notif
{
    [_cache removeAllObjects];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [_cache objectForKey:key];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    @synchronized(self) {
        [_cache setObject:image forKey:key];
    }
}

- (void)downloadImageAtURL:(NSURL *)url completionHandler:(void (^)(UIImage *image))completion
{
    UIImage *cachedImage = [self imageForKey:[url absoluteString]];
    if (cachedImage) {
        completion(cachedImage);
    } else {

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [self setImage:image forKey:[url absoluteString]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        });
    }
}

@end
